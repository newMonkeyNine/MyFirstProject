<template>
    <section>
        <template>
            <div class="task-info">
                <p v-text="bomInfo.projectName"></p>
                <p v-text="bomInfo.projectCode"></p>
                <div class="total-amount">
                    <div>
                        <span class="icon icon-shopping-cart"></span>批次
                        <span class="amount" v-text="bomInfo.batchNumber"></span>
                    </div>
                    <div>
                        <span class="icon icon-setting"></span>标准件
                        <span class="amount" v-text="bomInfo.productNumber">247</span>
                    </div>
                </div>
            </div>
            <ul>
                <!--批次1-->
                <template v-if="bomDetailData.length>0">
                    <li class="batch" v-for="items in bomDetailData">
                        <h3>
                            <span class="icon icon-batch"></span>{{items.batchCode}}</h3>
                        <ul class="list" v-if="items.bomDetails.length>0">
                            <li class="list-item" v-for="detail in items.bomDetails" v-bind:class="myDataPipe(detail, 'classListItem')">
                                <div class="name">
                                    <p>{{detail.productVO.productCode}} {{detail.productVO.productName}} {{detail.productVO.propertys}}</p>
                                    <span v-text="detail.number"></span>
                                </div>
                                <p>
                                    <span class="status" v-bind:class="myDataPipe(detail, 'classStatus')">{{detail | myDataPipe('bomStatus')}}</span>
                                    <span class="tip" v-bind:class="myDataPipe(detail, 'classTip')"> {{detail | myDataPipe('dateStr')}}</span>
                                </p>
                            </li>
                        </ul>
                    </li>
                </template>
            </ul>
        </template>
    </section>
</template>

<script type="text/ecmascript-6">
import utils from '../../utils/utils.js';

export default {
    name: 'engineeringDepartDetail',
    data: function() {
        return {
            bomInfo: {},
            bomDetailData: [],
            myDataPipe: utils.myDataPipe
        }
    },
    created: function() {
        this.bomInfo = Object.assign({}, this.$route.params);
        this.initData();
    },
    methods: {
        initData: function() {
            const data = {
                "projectId": this.bomInfo.projectId
            };
            // const bomStatus = {
            //     "00": { text: "待领取", listItem: '', tip: 'tip-overdue', status: '' },
            //     "01": { text: "待领取", listItem: '', tip: 'tip-overdue', status: 'printed' },
            //     "02": { text: "已领取", listItem: 'finished', tip: '', status: '' },
            //     "03": { text: "已过期", listItem: 'overdue', tip: '', status: '' },
            //     "20": { text: "未审批", listItem: '', tip: '', status: '' },
            //     "21": { text: "已审批", listItem: 'finished', tip: 'tip-operate', status: '' },
            //     "10": { text: "未采购", listItem: '', tip: '', status: '' },
            //     "11": { text: "未采购", listItem: '', tip: '', status: '', status: 'printed' },
            //     "12": { text: "采购中", listItem: '', tip: 'tip-arrive', status: '' },
            //     "13": { text: "已到货", listItem: 'finished', tip: 'tip-operate', status: '' },
            //     "14": { text: "已转领料", listItem: 'finished', tip: '', status: '' }
            // }
            this.$axiosHttp.axiosPost('/service-materials/bomContraller/findBomDetailByProjectId.api', data)
                .then(response => {
                    if (response.code === 200) {
                        const copyResponse = response.data.slice();
                        // copyResponse.slice().forEach(function(element, items) {
                        //     element.bomDetails.forEach(function(elementItem, index) {
                                // if (copyResponse[items]['bomDetails'][index]['bomStatus'] === "21") {
                                //     copyResponse[items]['bomDetails'][index]['dateStr'] = '请及时申请采购';
                                // } else if (copyResponse[items]['bomDetails'][index]['bomStatus'] === "13") {
                                //     copyResponse[items]['bomDetails'][index]['dateStr'] = '请及时申请领料';
                                // } else if (['02','03','20','21','10','11','14'].indexOf(elementItem['bomStatus']) != -1){
                                //     copyResponse[items]['bomDetails'][index]['dateStr'] = '';
                                // }else if (copyResponse[items]['bomDetails'][index]['bomStatus'] === "12") {
                                //     copyResponse[items]['bomDetails'][index]['dateStr'] = elementItem['deliveryDate']+'到货';
                                // }
                                // copyResponse[items]['bomDetails'][index]['status'] = bomStatus[elementItem.bomStatus].status;
                                // copyResponse[items]['bomDetails'][index]['tip'] = bomStatus[elementItem.bomStatus].tip;
                                // copyResponse[items]['bomDetails'][index]['listItem'] = bomStatus[elementItem.bomStatus].listItem;
                                // if(['13','14'].indexOf(elementItem['bomStatus']) != -1){
                                //     copyResponse[items]['bomDetails'][index]['bomStatus'] = `${bomStatus[elementItem.bomStatus].text}(${elementItem.purchaseOpDate})`;
                                // }else{
                                //     copyResponse[items]['bomDetails'][index]['bomStatus'] = bomStatus[elementItem.bomStatus].text;
                                // }

                        //     }, this);
                        // }, this);
                        this.bomDetailData = copyResponse;
                    } else {
                        this.$subscribe.trigger('promptBoxMsg', [response.msg]);
                    }
                });
        }
    },
    mounted: function() {
        this.$subscribe.trigger('title', '专案详情');
        this.$subscribe.trigger('headerClassName', 'bom-detail');
    }
}
</script>

<style type="text/css">

</style>