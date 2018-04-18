<template>
    <!--已处理-->
    <section>
        <routerView @inputSearchBox='inputSearchBox' :routerJump="routerJump"></routerView>
        <ul class="processed" v-bind:class="result" ref="scrollBom">
            <li class="batch" v-for="bomList in bomLists">
                <div class="task-info">
                    <p v-text="bomList.projectName"></p>
                    <div>
                        <span v-text="bomList.projectCode"></span>
                        <div class="leader"><span class="icon icon-leader"></span>{{bomList.projectPmName}}</div>
                    </div>
                </div>
                <ul class="list" v-if="bomList.details.length != 0">
                    <li class="list-item" v-for="detail in bomList.details">
                        <div class="name">
                            <p>{{detail.productVO.productName}} {{detail.productVO.propertys}}</p>
                            <span v-text="detail.number"></span>
                        </div>
                        <div>
                            <span class="applier">申请:{{detail.createId}}</span>
                            <div class="tip tip-arrive" v-bind:class="{'heightlight': detail.isChange}">
                                <span v-if="! detail.isChange">{{detail.deliveryDate}}</span>
                                <div class="date" v-if="detail.isChange" v-text="detail.deliveryDate" v-on:click.stop="selectCurrentdDate(detail.deliveryDate)"></div>
                                <button class="edit" type="button" v-on:click.stop="changeCurrentdDate(detail)" v-text="detail.buttonText"></button>
                            </div>
                        </div>
                    </li>
                </ul>
            </li>
            <li class="loading-more" v-if="pagination">正在加载...</li>
        </ul>
    </section>
</template>

<script type="text/ecmascript-6">

import utils from '../../utils/utils.js';
import mixin from '../../utils/mixin.js'
import routerView from '../base/routerView.vue';

export default {
    name: 'purchasingDepartUntreated',
    mixins: [mixin.paginationMixin],
    data: function() {
        return {
            bomLists: [],
            nowPage: 1,
            result:'',
            pagination: false,
            currentSelectItem: [],
            routerJump: {
                'manageShow': true,
                'disable': { 'router': 'purchasingDepartLose', 'text': '未处理' },
                'active': { 'router': 'purchasingDepartUntreated', 'text': '已处理' }
            }
        }
    },
    mounted: function() {
        this.$subscribe.trigger("isButtonShow", false);
        this.$subscribe.trigger('headerClassName', 'buyer-home');
    },
    created: function() {
        this.initData();
        this._subscribe();
    },
    methods: {
        initData: function(projectName) {
            const data = {
                "nowPage": this.nowPage,
                'projectName': projectName || ''//默认projectName值为'',类似于es6 function(projectName=''){...}
            };
            this.$axiosHttp.axiosPost('/service-materials/bomContraller/findPurchaseProcessedStatus.api', data)
                .then(response => {
                    this.pagination = false
                    if (response.code === 200) {
                        let copyData = response.data.bomList.slice()
                        copyData.slice().forEach(function(element, itemIndex) {
                            element.details.forEach(function(element, listindex) {
                                copyData[itemIndex]['details'][listindex]['buttonText'] = '修改';
                                copyData[itemIndex]['details'][listindex]['isChange'] = false;
                            }, this)
                        }, this);
                        this.nowPage += 1; 
                        response.data.lastPage === 0? this.pagination = false : this.pagination = true;
                        this.bomLists = this.bomLists.slice().concat(copyData.slice());
                    }else if(response.code === 1300){
                        this.bomLists = []; 
                        data.projectName.trim() == ''? this.result='empty':this.result='no-result'; 
                    } else {
                        this.$subscribe.trigger('promptBoxMsg', [response.msg]);
                    }
                });
        },
        inputSearchBox(data) {//搜索+数据还原
            this.nowPage = 1;
            this.bomLists = [];
            this.pagination = true;
            this.initData(data)
        },
        changeCurrentdDate(detail) {
            if (detail.isChange) {
                this.saveData([{
                    'bomDetailId': detail['gid'],
                    'deliveryDate': detail['deliveryDate']
                }]);
                detail.isChange = false;
            } else {
                detail.isChange = true;
            }
            this.currentSelectItem = detail;
            detail.isChange ? detail.buttonText = '保存' : detail.buttonText = '修改';
        },
        selectCurrentdDate(date) {
            const mask = { isShow: true, type: 'datePicker' }
            this.$subscribe.trigger('datePickerMask', mask, date);
        },
        _subscribe: function() {
            let self = this;
            this.$subscribe.listen("getDatePicker", function(date) {
                self.currentSelectItem.deliveryDate = date;
                const mask = { isShow: false, type: 'datePicker' }
                self.$subscribe.trigger('datePickerMask', mask, date);
            });
        },
        saveData: function(httpData) {
            const data = {
                "list": httpData
            };
            // this.nowPage = 1;
            // this.pagination = true;
            this.$axiosHttp.axiosPost('/service-materials/bomContraller/changeDeliveryDate.api', data)
                .then(response => {
                    if (response.code === 200) {
                        // this.initData();
                        this.inputSearchBox();
                    } else {
                        this.$subscribe.trigger('promptBoxMsg', [response.msg]);
                    }
                });
        }
    },
    // destroyed: function() {
    //     this.$subscribe.remove("getDatePicker");
    // },
    components: {
        routerView: routerView
    }
}
</script>

<style type="text/css">

</style>