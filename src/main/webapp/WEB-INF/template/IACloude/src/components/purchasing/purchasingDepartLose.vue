<template>
    <section>
        <routerView @inputSearchBox='inputSearchBox' :routerJump="routerJump"></routerView>
        <!--待处理-->
        <ul class="wait-process" v-bind:class="result" ref="scrollBom">
            <li class="batch" v-for="bomList in bomLists">
                <div class="task-info">
                    <p v-text="bomList.projectName"></p>
                    <div>
                        <span v-text="bomList.projectCode"></span>
                        <div class="leader">
                            <span class="icon icon-leader"></span>{{bomList.projectPmName}}</div>
                    </div>
                </div>
                <ul class="list" v-if="bomList.details != 0">
                    <li class="list-item" v-for="detail in bomList.details">
                        <div class="name">
                            <p>{{detail.productVO.productName}} {{detail.productVO.propertys}}</p>
                            <span v-text="detail.number">5</span>
                        </div>
                        <div>
                            <span class="applier">申请:{{detail.createId}}</span>
                            <div class="tip tip-arrive">
                                <div class="date" v-on:click.stop="selectCurrentdDate(detail)" v-text="detail.date"></div>
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
    name: 'purchasingDepartLose',
    mixins: [mixin.paginationMixin],
    mounted: function() {
        this.$subscribe.trigger('headerClassName', 'buyer-home');
    },
    data: function() {
        return {
            nowPage: 1,
            result: '',
            bomLists: [],
            pagination: false,
            currentSelectItem: [],
            routerJump: {
                'manageShow': true,
                'active': { 'router': 'purchasingDepartLose', 'text': '未处理' },
                'disable': { 'router': 'purchasingDepartUntreated', 'text': '已处理' }
            }

        }
    },
    created: function() {
        this.initData();
        this._subscribe();
        this._changDateSubscribe();
    },
    methods: {
        initData: function(projectName) {
            const data = {
                "nowPage": this.nowPage,
                'projectName': projectName || '' //默认projectName值为'',类似于es6 function(projectName=''){...}
            };
            this.$axiosHttp.axiosPost('/service-materials/bomContraller/findPurchaseStatus.api', data)
                .then(response => {
                    this.pagination = false
                    if (response.code === 200) {
                        let copyData = response.data.bomList.slice()
                        copyData.slice().forEach(function(element, itemIndex) {
                            element.details.forEach(function(element, listindex) {
                                copyData[itemIndex]['details'][listindex]['date'] = '请选择交期';
                                copyData[itemIndex]['details'][listindex]['selectDate'] = false;
                            }, this)
                        }, this);
                        this.nowPage += 1; this.empty = false;
                        response.data.lastPage === 0 ? this.pagination = false : this.pagination = true;
                        this.bomLists = this.bomLists.slice().concat(copyData.slice());
                    } else if (response.code === 1300) {
                        this.bomLists = [];
                        data.projectName.trim() == '' ? this.result = 'empty' : this.result = 'no-result';
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
        selectCurrentdDate(detail) {
            if (this.currentSelectItem.length != 0) {
                this.currentSelectItem.selectDate = false;
            }
            detail.selectDate = true;
            this.currentSelectItem = detail;
            const mask = { isShow: true, type: 'datePicker' }
            if (utils.isDataFormat(detail.date)) {
                this.$subscribe.trigger('datePickerMask', mask, detail.date);
            } else {
                this.$subscribe.trigger('datePickerMask', mask, '');
            }
        },

        _changDateSubscribe: function() {
            let self = this;
            this.$subscribe.listen("getDatePicker", function(date) {
                self.currentSelectItem.date = date;
                const mask = { isShow: true, type: 'datePicker' }
                self.$subscribe.trigger('datePickerMask', false);
                self.$subscribe.trigger("isButtonShow", true);
            });
        },
        _subscribe: function() {
            let self = this;
            this.$subscribe.listen("saveButtonClick", function() {
                let httpData = [];
                self.bomLists.slice().forEach(function(element) {
                    element.details.forEach(function(detailsElement) {
                        if (utils.isDataFormat(detailsElement['date'])) {
                            httpData.push({
                                'bomDetailId': detailsElement['gid'],
                                'deliveryDate': detailsElement['date']
                            });
                        }
                    }, this)
                }, this);
                self.saveData(httpData);
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
                        this.inputSearchBox();
                    } else {
                        this.$subscribe.trigger('promptBoxMsg', [response.msg]);
                    }
                });
        },
    },
    components: {
        routerView
    }
}
</script>

<style type="text/css">

</style>