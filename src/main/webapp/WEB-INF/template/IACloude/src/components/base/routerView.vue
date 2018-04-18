<template>
    <div class="search-bar-container">
        <div class="search-bar">
            <span class="icon icon-search"></span>
            <!--输入框获得焦点时，添加class:focus，没有内容时失去焦点，移除class:focus，有内容时点击删除图标再移除class:focus-->

            <input v-bind:class="{'focus': focus}" type="search" value="" v-on:focus="inputFocus" v-on:blur="inputBlur" placeholder="请输入专案名称" v-model="search" ref="inputSearch" />

            <!--输入框有内容时显示，没有内容时隐藏-->
            <span class="icon icon-close" v-if="iconClose" v-on:click="deleteInput"></span>
        </div>
        <div class="manage" v-show="routerJump.manageShow">
            <div class="manage-operation" ref="manageOperation">
                <p class="content" ref="manageOperationContent" v-text="routerJump.active.text"></p>
                <ul class="dropDown" ref="manageOperationItem">
                    <li class="item" v-bind:data-router="routerJump.disable.router" v-text="routerJump.disable.text"></li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script type="text/ecmascript-6">

import mixin from '../../utils/mixin.js'

export default {
    name: 'inputSearchBox',
    mixins: [mixin.searchMixin],
    props: {
        routerJump: {
            type: Object
        }
    },
    methods: {
        searchData: function(newVal) {
            this.$emit('inputSearchBox', newVal);
        },
        initSelect: function() {
            let self = this;

            const manageOperationDOM = this.$refs.manageOperation;
            const manageOperationContent = this.$refs.manageOperationContent;
            const manageOperationItem = this.$refs.manageOperationItem;

            manageOperationContent.addEventListener('click', function(event) {
                event.stopPropagation();
                manageOperationDOM.classList.toggle('open');
            }, false);

            manageOperationItem.addEventListener('click', function(event) {
                event.stopPropagation();
                self.$router.push({ name: `${event.target.dataset.router}` });
                manageOperationDOM.classList.toggle('open');
            }, false);

            document.querySelector('section').addEventListener('click', function() {
                manageOperationDOM.classList.remove('open');
            });
        }
    },
    mounted: function() {
        this.initSelect();
        this.$subscribe.trigger('title', '申请列表');
    }
}
</script>
