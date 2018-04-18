<template>
    <div>
        <section>
            <div class="search-bar-container">
                <div class="search-bar">
                    <span class="icon icon-search"></span>
                    <!--输入框获得焦点时，添加class:focus，没有内容时失去焦点，移除class:focus，有内容时点击删除图标再移除class:focus-->
                    <input type="search" v-bind:class="{'focus': focus}" value="" placeholder="请输入专案名称" v-model="search" />
                    <!--输入框有内容时显示，没有内容时隐藏-->
                    <span class="icon icon-close"></span>
                </div>
                <div class="manage">
                    <div class="manage-operation" ref="manageOperation">
                        <p class="content" ref="manageOperationContent">未处理</p>
                        <ul class="dropDown" ref="manageOperationItem">
                            <li data-router='untreated' class="item">已处理</li>
                            <li data-router='lose' class="item active">未处理</li>
                        </ul>
                    </div>
                </div>
            </div>
            <router-view></router-view>
        </section>
        <div class="mask" v-show="mask.isShow"></div>
        <aside class="dialog dialog-assign" v-show="mask.isShow" v-bind:class="{ 'not-arrive': arriveMsg }">
            <header>
                <span class="icon icon-arrow-left" v-on:click.stop="arriveMsg = false"></span>
                <h3>指派至</h3>
                <button class="toggle-assign" type="button" v-if="mask.notArrival" v-on:click.stop="arriveMsg = true">未到货？</button>
            </header>
            <section>
                <div class="check-group">
                    <input type="radio" id="radio01" name="assign" value='project' v-model="radioValue" />
                    <label class="task" for="radio01">本专案</label>

                    <input type="radio" id="radio02" name="assign" value='warehouse' v-model="radioValue"  />
                    <label class="storage" for="radio02">仓库</label>
                </div>
                <p class="not-arrive-describe">
                    物料退回供应商或其他原因导致未到货 可将其退回至 [未处理]
                </p>
            </section>
            <footer>
                <button class="ok" type="button" v-on:click.stop="confirm">确定</button>
                <button class="cancel" type="button" v-on:click.stop="cancel">取消</button>
            </footer>
        </aside>
    </div>
</template>

<script type="text/ecmascript-6">
export default {
    name: 'storehouse',
    data: function() {
        return {
            mask: {
                notArrival: false,
                isShow: false,
            },
            search: '',
            focus: false,
            timeout: null,
            arriveMsg: false,
            radioValue:'project'
        }
    },

    created: function() {
        this._subscribe();
    },
    mounted: function() {
        this.initSelect();
        this.$subscribe.trigger('headerClassName', 'store-home');
    },
    watch: {
        search: function(newVal, oldVal) {
            let self = this;
            window.clearTimeout(self.timeout);
            self.timeout = window.setTimeout(() => {
                this.$subscribe.trigger('search', newVal);
                newVal=="" ?this.focus=false: this.focus=true;
            }, 300);
        }
    },
    methods: {
        _subscribe: function() {
            let self = this;
            this.$subscribe.listen("mask", function(data) {
                self.mask = data;
            })
        },
        cancel: function() {
            this.arriveMsg = false;
            this.radioValue='project';
            this.mask.isShow = false;
        },
        confirm: function() {
            if(this.arriveMsg){
                this.$subscribe.trigger('storehouseLoseAssigned', '12');
            }else{
                this.$subscribe.trigger('storehouseLoseAssigned',this.radioValue==='project' ? '14' : '13');
            }
            this.cancel();
        },
        getScrollHeight: function() {
            var scrollHeight = 0, bodyScrollHeight = 0, documentScrollHeight = 0;
            if (document.body) {
                bodyScrollHeight = document.body.scrollHeight;
            }
            if (document.documentElement) {
                documentScrollHeight = document.documentElement.scrollHeight;
            }
            scrollHeight = (bodyScrollHeight - documentScrollHeight > 0) ? bodyScrollHeight : documentScrollHeight;
            return scrollHeight;
        },
        //浏览器视口的高度
        getWindowHeight: function() {
            var windowHeight = 0;
            if (document.compatMode == "CSS1Compat") {
                windowHeight = document.documentElement.clientHeight;
            } else {
                windowHeight = document.body.clientHeight;
            }
            return windowHeight;
        },
        getScrollTop: function() {
            var scrollTop = 0, bodyScrollTop = 0, documentScrollTop = 0;
            if (document.body) {
                bodyScrollTop = document.body.scrollTop;
            }
            if (document.documentElement) {
                documentScrollTop = document.documentElement.scrollTop;
            }
            scrollTop = (bodyScrollTop - documentScrollTop > 0) ? bodyScrollTop : documentScrollTop;
            return scrollTop;
        },
        initSelect: function() {
            let self = this;
            const manageOperationDOM = this.$refs.manageOperation;
            const manageOperationContent = this.$refs.manageOperationContent;
            const manageOperationItem = this.$refs.manageOperationItem;

            manageOperationContent.addEventListener('touchend', function(event) {
                event.stopPropagation();
                manageOperationDOM.classList.toggle('open');
            }, false);

            manageOperationItem.addEventListener('touchend', function(event) {
                event.stopPropagation();
                if (self.$route.name != event.target.textContent) {
                    self.$router.push({ name: `${event.target.dataset.router}` });
                }
                self.$subscribe.trigger("isButtonShow", false);
                manageOperationContent.innerHTML = event.target.textContent;
                var parentDom = event.target.parentNode.childNodes;
                Array.prototype.slice.call(parentDom).forEach(function(item) {
                    if (item.nodeName.toLowerCase() === 'li') {
                        event.target == item ? item.classList.add('active') : item.classList.remove('active');
                    }
                });
                manageOperationDOM.classList.toggle('open');
            }, false);

            document.body.addEventListener('touchend', function() {
                manageOperationDOM.classList.remove('open');
            });
            window.onscroll = function() {
                window.clearTimeout(self.timeout);
                self.timeout = window.setTimeout(() => {
                    if (self.getScrollTop() + self.getWindowHeight() >= self.getScrollHeight()-30) {
                        self.$subscribe.trigger('pagination');
                    }
                }, 300);
            }
        }
    },
    destroyed: function() {
        this.$subscribe.remove("mask");
    }
}
</script>

<style type="text/css">
</style>