<template>
    <div></div>
</template>

<script type="text/ecmascript-6">

export default {
    name: 'start',
    created: function() {
        this.initData();
    },
    methods: {
        initData: function() {
            this.$axiosHttp.axiosGet('/service-materials/bomContraller/getRoleName.api')
                .then(response => {
                    if (response.code == 200) {
                        if (response.data.roleName === "机构工程师") {
                            this.$router.push({ name: "engineeringDepart" });
                        } else if (response.data.roleName === "资料员") {
                            this.$router.push({ name: "storehouseLose" });
                        } else if (response.data.roleName === "采购") {
                            this.$router.push({ name: "purchasingDepartLose" });
                        }
                    }else{
                        this.$subscribe.trigger('promptBoxMsg', [response.msg]);
                    }
                });
        }
    }
}
</script>