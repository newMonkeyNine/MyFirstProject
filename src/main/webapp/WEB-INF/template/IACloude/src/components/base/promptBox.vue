<template>
    <aside class="toast" v-bind:class="{'dialog-hidde':isShowPromptBox }">
        <h3>提示</h3>
        <p v-for="(item,index) in setpromptMessage" :key="index" v-text="item"></p>
    </aside>
</template>
<script>
export default {
    name: 'promptBox',
    data() {
        return {
            // 提示框是否显示
            isShowPromptBox: false,
            setpromptMessage: []
        }
    }, created: function() {
        this._subscribe();
    },

    methods: {
        _subscribe: function() {
            var self = this;
            this.$subscribe.listen("promptBoxMsg", function(data) {
                self.setpromptMessage = data.slice();
                self.showpromptMessage();
            })
        },
        showpromptMessage: function() {
            this.isShowPromptBox = true;
            const timeout = window.setTimeout(function() {
                window.clearTimeout(timeout);
                this.isShowPromptBox = false;
            }.bind(this), 1200);
        }
    },
    destroyed: function(){
        this.$subscribe.remove("promptBoxMsg");
    }
}
</script>
<style type="text/css">
.toast {
    display: none;
    position: fixed;
    left: 50%;
    top: 50%;
    width: 18rem;
    background: #fff;
    box-shadow: 0 0.25rem 1rem #b2c6c2;
    padding: 1rem;
    z-index: 1;
    transform: translateX(-50%) translateY(-50%);
}

.toast h3 {
    text-align: center;

    height: 3rem;
    line-height: 3rem;
}

.toast p {
    text-align: center;
    font-size: 0.875rem;
}
.dialog-hidde {
    display: block !important;
}
</style>