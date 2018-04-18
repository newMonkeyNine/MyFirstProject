<template>
    <div>
        <section>
            
            
        </section>
        <!-- <div class="mask" v-if="mask" v-on:click.stop="mask = false"></div>
        <DatePicker v-bind:datePicker="datePicker" v-bind:mask="mask"></DatePicker> -->
    </div>
</template>

<script type="text/ecmascript-6">
import mixin from '../../utils/mixin.js'
import DatePicker from '../base/datePicker.vue'

export default {
    name: 'purchasingDepart',
    data: function() {
        return {
            mask: false,
            // search: '',
            // focus: false,
            currentData: '',
            // timeout: null,
            datePicker: ''
        }
    },
    created: function() {
        this._subscribe();
    },
    mounted: function() {
        this.initSelect();
        this.$subscribe.trigger('headerClassName', 'buyer-home');
    },
    // watch: {
    //     search: function(newVal, oldVal) {
    //         let self = this;
    //         window.clearTimeout(self.timeout);
    //         self.timeout = window.setTimeout(() => {
    //             newVal=="" ?this.focus=false: this.focus=true;
    //             this.$subscribe.trigger('search', newVal);
    //         }, 300);
    //     }
    // },
    methods: {
        _subscribe: function() {
            let self = this;
            this.$subscribe.listen("datePickerMask", function(isShow, date) {
                if(date) self.datePicker = date;
                isShow ? self.mask = true : self.mask = false;
            });
        },
        // getScrollHeight: function() {
        //     var scrollHeight = 0, bodyScrollHeight = 0, documentScrollHeight = 0;
        //     if (document.body) {
        //         bodyScrollHeight = document.body.scrollHeight;
        //     }
        //     if (document.documentElement) {
        //         documentScrollHeight = document.documentElement.scrollHeight;
        //     }
        //     scrollHeight = (bodyScrollHeight - documentScrollHeight > 0) ? bodyScrollHeight : documentScrollHeight;
        //     return scrollHeight;
        // },
        // //浏览器视口的高度
        // getWindowHeight: function() {
        //     var windowHeight = 0;
        //     if (document.compatMode == "CSS1Compat") {
        //         windowHeight = document.documentElement.clientHeight;
        //     } else {
        //         windowHeight = document.body.clientHeight;
        //     }
        //     return windowHeight;
        // },
        // getScrollTop: function() {
        //     var scrollTop = 0, bodyScrollTop = 0, documentScrollTop = 0;
        //     if (document.body) {
        //         bodyScrollTop = document.body.scrollTop;
        //     }
        //     if (document.documentElement) {
        //         documentScrollTop = document.documentElement.scrollTop;
        //     }
        //     scrollTop = (bodyScrollTop - documentScrollTop > 0) ? bodyScrollTop : documentScrollTop;
        //     return scrollTop;
        // },

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
                if (self.$route.name != event.target.textContent) {
                    self.$router.push({ name: `${event.target.dataset.router}` });
                }
                self.search = '';
                manageOperationContent.innerHTML = event.target.textContent;
                var parentDom = event.target.parentNode.childNodes;
                Array.prototype.slice.call(parentDom).forEach(function(item) {
                    if (item.nodeName.toLowerCase() === 'li') {
                        event.target == item ? item.classList.add('active') : item.classList.remove('active');
                    }
                });
                manageOperationDOM.classList.toggle('open');
            }, false);

            document.body.addEventListener('click', function() {
                manageOperationDOM.classList.remove('open');
            })
            // window.onscroll = function() {
            //     window.clearTimeout(self.timeout);
            //     self.timeout = window.setTimeout(() => {
                    
            //         if (self.getScrollTop() + self.getWindowHeight() >= self.getScrollHeight()-30) {
            //             console.log(self.getScrollHeight());
            //             self.$subscribe.trigger('pagination');
            //         }
            //     }, 300);

            // }
        }
    },
    destroyed: function() {
        this.$subscribe.remove("datePickerMask");
    },
    components: {
        DatePicker
    }
}
</script>

<style type="text/css">

</style>