<template>
    <header>
        <a href="javascript:void(0);" class="icon-button left auto-width" v-on:click.stop="back">
            <span class="icon icon-arrow-left"></span>返回</a>
        <h1 v-text="title"></h1>
    </header>
</template>

<script type="text/ecmascript-6">
export default {
    name: 'header',
    data: function(){
        return {
            title: '',
            routerNames: ['engineeringDepart', 'purchasingDepartLose', 'storehouseLose', 'start']
        }
    },
    created: function(){
        this._titleSubscribe();
    },
    methods: {
        _titleSubscribe: function(){
            let self = this;
            this.$subscribe.listen("title", function(title) {
                self.title = title;
            });
        },

        back(){
            if(this.$router.history.current.name != 'engineeringDepartDetail'){
                if (typeof JSInterface === "undefined") {
					window.location.href = "next://http://iacloud.ceway.com.cn/app-xproject/"
				} else {
					JSInterface.changeActivity();
				}
            }else{
                this.$router.go(-1);
            }
            
        }
    },
    destroyed: function(){
        this.$subscribe.remove("title");
    }
}
</script>

<style type="text/css">

</style>
