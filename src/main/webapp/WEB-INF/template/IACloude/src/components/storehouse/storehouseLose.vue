<template>
    <section>
        <routerView @inputSearchBox='inputSearchBox' :routerJump="routerJump"></routerView>
        <ul class="wait-process" v-bind:class="result" ref="scrollBom">
            <li class="batch" v-for="items in bomLists">
                <div class="task-info">
                    <p v-text="items.projectName"></p>
                    <div>
                        <span v-text="items.projectCode"></span>
                        <div class="leader"><span class="icon icon-leader"></span>{{items.projectPmName}}</div>
                    </div>
                </div>
                <ul class="list">
                    <li class="list-item" v-for="detail in items.details">
                        <div class="name">
                            <p>{{detail.productVO.productName}} {{detail.productVO.propertys}}</p>
                            <span v-text="detail.number"></span>
                        </div>
                        <p class="applier">申请:{{detail.createId}}</p>
                        <p>
                            <span class="tip tip-arrive">{{detail.deliveryDate}}到货</span>
                            <button type="button" v-on:click.stop="confirm(detail)">确认收货</button>
                        </p>
                    </li>
                </ul>
            </li>
            <li class="loading-more" v-if="pagination">正在加载...</li>
        </ul>
    </section>
</template>


<script type="text/ecmascript-6">
import mixin from '../../utils/mixin.js'
import routerView from '../base/routerView.vue';
export default {
    name: 'storehouseLose',
    mixins: [mixin.paginationMixin],
    data: function() {
        return {
            result:'',
            bomLists: [],
            clickItem: null,
            nowPage: 1,
            pagination: false,
            routerJump: {
                'manageShow': true,
                'active': { 'router': 'storehouseLose', 'text': '未处理' },
                'disable': { 'router': 'storehouseUntreated', 'text': '已处理' }
            }
        }
    },
    created: function() {
        this.initData();
    },
    mounted: function() {
        this.$subscribe.trigger('headerClassName', 'store-home');
    },
    methods: {
        _subscribe: function(data) {
            const httpData = {
                "bomDetailId": this.clickItem.gid,
                "number": this.clickItem.number,
                "productId": this.clickItem.productVO.gid,
                "bomDetailStatus": data
            }
            this.changeStatus(httpData);
        },
        inputSearchBox(data) {//搜索+数据还原
            this.nowPage = 1;
            this.bomLists = [];
            this.pagination = true;
            this.initData(data)
        },
        initData: function(projectName) {
            const data = {
                "nowPage": this.nowPage,
                "projectName": projectName || ''//默认projectName值为'',类似于es6 function(projectName=''){...}
            };

            this.$axiosHttp.axiosPost('/service-materials/bomContraller/findWarehouseStatus.api', data)
                .then(response => {
                    this.pagination = false
                    if (response.code === 200) {
                        this.nowPage += 1; 
                        response.data.lastPage === 0? this.pagination = false : this.pagination = true;
                        this.bomLists = this.bomLists.slice().concat(response.data.bomList.slice());
                    } else if (response.code === 1300) {
                        this.bomLists = []; 
                        data.projectName.trim() == ''? this.result='empty':this.result='no-result'; 
                    } else {
                        this.$subscribe.trigger('promptBoxMsg', [response.msg]);
                    }
                });
        },
        changeStatus: function(data) {
            // this.nowPage = 1;
            // this.bomLists = [];
            // this.pagination = true;
            this.$axiosHttp.axiosPost('/service-materials/bomContraller/specifYmaterialType.api', data)
                .then(response => {
                    if (response.code === 200) {
                        // this.initData();
                        this.inputSearchBox();
                    } else {
                        this.$subscribe.trigger('promptBoxMsg', [response.msg]);
                    }
                });
        },
        confirm: function(detail) {
            this.clickItem = detail;
            const mask = { isShow: true, type: 'storehouse' };
            const dialogAssign = { 
                isArrive: false, notArrival: false, 
                bomstatus: '', func: this._subscribe 
            };
            this.$subscribe.trigger('dialogMask', mask, dialogAssign);
        }
    },
    components: {
        routerView
    }
}
</script>


