<template>
    <section>
        <routerView @inputSearchBox='inputSearchBox' :routerJump="routerJump"></routerView>
        <ul ref="scrollBom" v-bind:class="result" >
            <li class="task-info" v-bind:class="{'empty': item.batchNumber == 0}"
                    v-for="item in bomLists" v-on:click="redirectDetail(item)">
                <p v-text="item.projectName"></p>
                <p v-text="item.projectCode"></p>
                <div class="total-amount">
                    <div>
                        <span class="icon icon-shopping-cart"></span>批次
                        <span class="amount" v-text="item.batchNumber"></span>
                    </div>
                    <div>
                        <span class="icon icon-setting"></span>标准件
                        <span class="amount" v-text="item.productNumber"></span>
                    </div>
                </div>
            </li>
            <li class="loading-more" v-if="pagination">正在加载...</li>
        </ul>
    </section>
</template>

<script type="text/ecmascript-6">
import mixin from '../../utils/mixin.js'
import routerView from '../base/routerView.vue';

export default {
    name: 'engineeringDepart',
    mixins: [mixin.searchMixin, mixin.paginationMixin],
    data: function() {
        return {
            nowPage: 1,
            result:'',
            pagination: false,
            bomLists: [],
            routerJump: {
                'manageShow': false,
                'active': { 'router': '', 'text': '' },
                'disable': { 'router': '', 'text': '' }
            }
        }
    },
    created: function() {
        this.initData();
    },
    methods: {
        initData: function(projectName) {
            const data = {
                "nowPage": this.nowPage,
                'projectName': projectName || ''//默认projectName值为'',类似于es6 function(projectName=''){...}
            };
            this.$axiosHttp.axiosPost('/service-materials/bomContraller/findApplicationStatus.api', data)
                .then(response => {
                    this.pagination = false
                    if (response.code === 200) {
                        this.nowPage += 1;
                        const respData = response.data;
                        let respDataCopy = respData.engineeringVOs.slice();
                        respData.lastPage === 0 ? this.pagination = false : this.pagination = true;
                        respDataCopy.slice().forEach(function(element, index) {
                            if(! element['productNumber']){
                                respDataCopy[index]['productNumber'] = '0';
                            }
                        }, this);
                        this.bomLists = this.bomLists.slice().concat(respDataCopy.slice());
                    }else if (response.code === 1301){
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
        redirectDetail(item) {
            if (item.batchNumber == 0) return
            this.$router.push(
                {
                    name: 'engineeringDepartDetail',
                    params: {
                        projectId: item.projectId,
                        projectName: item.projectName,
                        projectCode: item.projectCode,
                        batchNumber: item.batchNumber,
                        productNumber: item.productNumber
                    }
                })
        },
    },
    mounted: function() {
        this.$subscribe.trigger('title', '专案列表');
        this.$subscribe.trigger('headerClassName', 'engineer-home');
    },
    components: {
        routerView: routerView
    }
}
</script>

<style type="text/css">

</style>
