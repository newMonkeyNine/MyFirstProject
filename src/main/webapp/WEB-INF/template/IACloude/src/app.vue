<template>
    <div class="app">
        <article v-bind:class="className">
            <promptBox></promptBox>
            <baseHeader></baseHeader>
            <keep-alive>
                <transition name="fade" mode="out-in">
                    <router-view></router-view>
                </transition>
            </keep-alive>
            <footer v-if="isButtonShow" v-on:click.stop="save">
                <button class="btn-save" type="button">保存</button>
            </footer>
        </article>
        <loading></loading>
    </div>
</template>

<script type="text/ecmascript-6">
import loading from './components/base/loading.vue'
import baseHeader from './components/base/baseHeader.vue'
import promptBox from './components/base/promptBox.vue'

export default {
    name: 'app',
    data: function() {
        return {
            isButtonShow: false,
            className: 'store-home',
        }
    },
    created: function() {
        this._subscribe();
        this._saveSubscribe();
    },
    methods: {
        _subscribe: function() {
            let self = this;
            this.$subscribe.listen("headerClassName", function(name) {
                self.className = name;
            })
        },
        _saveSubscribe: function() {
            let self = this;
            this.$subscribe.listen("isButtonShow", function(isShow) {
                self.isButtonShow = isShow;
            });
        },
        save() {
            this.isButtonShow = false;
            this.$subscribe.trigger('saveButtonClick');
        },
    },
    components: {
        loading,
        promptBox,
        baseHeader,
    },
    destroyed: function(){
        this.$subscribe.remove("isButtonShow");
    }
}
</script>
<style type="text/css">
.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.2s;
}

.fade-enter,
.fade-leave-to {
    opacity: 0;
}
</style>

