<template>
    <div>
        <transition name="fade">
            <div class="ui-datepicker-wrapper" v-show="mask" ref="wrapper">
                <div class="ui-datepicker-header">
                    <a href="javascript:void(0);" class="ui-datepicker-btn ui-datepicker-prev-btn">&lt;</a>
                    <a href="javascript:void(0);" class="ui-datepicker-btn ui-datepicker-next-btn">&gt;</a>
                    <span class="datepicker-curr-month">{{monthData.year}}-{{monthData.month|myDataPipe('month')}}</span>
                </div>
                <div class="ui-datepicker-body">
                    <table>
                        <thead>
                            <tr>
                                <th>一</th>
                                <th>二</th>
                                <th>三</th>
                                <th>四</th>
                                <th>五</th>
                                <th>六</th>
                                <th>日</th>
                            </tr>
                        </thead>
                        <tbody v-if="monthData.days">
                            <tr v-for="(itemDays, itemIndex) in monthData.days">
                                <template v-for="(item, listIndex) in itemDays">
                                    <td v-bind:class="item.className" v-bind:data-date="item.date" v-bind:data-disable="item.disable" v-text="item.showDate" @click="dateSelect(itemIndex, listIndex)"></td>
                                </template>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </transition>
    </div>
</template>

<script type="text/ecmascript-6">
import utils from '../../utils/utils.js';
import monthData from '../../utils/getDate'

export default {
    name: 'Datepicker',
    data() {
        return {
            monthData: {},
            isOpen: false
        }
    },
    props: {
        mask: {
            type: Boolean,
            default: false
        }
    },
    mounted: function() {
        this.restoreData('', true);
    },
    methods: {
        restoreData: function(date, isAuto) {
            this._getDate(date, isAuto);
            this.$nextTick(function() {
                this._initData();
            });
        },
        _getDate: function(date, isAuto) {
            this.monthData = monthData.getMonthData(date, isAuto);
        },
        _dateRender(direction) {
            let year, month;
            if (this.monthData) {
                year = this.monthData.year;
                month = this.monthData.month;
            }
            if (direction === 'prev') month--;
            if (direction === 'next') month++;
            var self = this;
            utils.debounce(function() {
                self._getDate(year + '-' + month, false);
            }, 200);
        },
        format(date) {
            var ret = '';
            var padding = function(num) {
                if (num <= 9) {
                    return '0' + num;
                }
                return num;
            };
            ret += date.getFullYear() + '-';
            ret += padding(date.getMonth() + 1) + '-';
            ret += padding(date.getDate());

            return ret;
        },
        dateSelect: function(itemIndex, listIndex) {
            let copyMonthData = this.monthData.days.slice();
            if (copyMonthData[itemIndex][listIndex].disable === 'disable') {
                return
            }
            copyMonthData.slice().forEach(function(element, item) {
                element.forEach(function(elementItem, index) {
                    if (elementItem.className === 'active') {
                        copyMonthData[item][index].className = '';
                    }
                }, this);
            }, this);
            var self = this;
            copyMonthData[itemIndex][listIndex].className = 'active';
            this.monthData.days = copyMonthData.slice();
            utils.debounce(function() {
                var date = new Date(
                    self.monthData.year,
                    self.monthData.month - 1,
                    copyMonthData[itemIndex][listIndex].date
                );
                self.$subscribe.trigger('getDatePicker', self.format(date));
            }, 500);
        },
        _initData: function() {
            let self = this;
            let $wrapper = this.$refs.wrapper;
            $wrapper.addEventListener('click', function(event) {

                event.stopPropagation();
                var $target = event.target;
                if (!$target.classList.contains('ui-datepicker-btn')) {
                    return false;
                }
                if ($target.classList.contains('ui-datepicker-prev-btn')) {
                    self._dateRender('prev');
                } else if ($target.classList.contains('ui-datepicker-next-btn')) {
                    self._dateRender('next');
                }
            }, false);
        }
    }
}
</script>
<style type="text/css">
.ui-datepicker-wrapper {
    position: absolute;
    top: 50%;
    left: 50%;
    z-index: 99;
    display: block;
    width: 80%;
    font-size: 16px;
    color: rgba(0, 0, 0, .87);
    background-color: #fff;
    transform: translate(-50%, -50%);
}

.ui-datepicker-wrapper-show {
    display: block;
}

.ui-datepicker-wrapper .ui-datepicker-header {
    padding: 0 20px;
    height: 50px;
    line-height: 50px;
    text-align: center;
    background-color: #424242;
    font-weight: bold;
    color: rgba(255, 255, 255, .87);
}

.ui-datepicker-wrapper .ui-datepicker-body {
    padding: .5rem;
}

.ui-datepicker-wrapper .ui-datepicker-btn {
    font-family: SansSerif;
    font-size: 20px;
    width: 20px;
    height: 50px;
    line-height: 50px;
    color: rgba(255, 255, 255, .87);
    text-align: center;
    cursor: pointer;
    text-decoration: none;
}

.ui-datepicker-wrapper .ui-datepicker-prev-btn {
    float: left;
}

.ui-datepicker-wrapper .ui-datepicker-next-btn {
    float: right;
}

.ui-datepicker-wrapper .ui-datepicker-body table {
    width: 100%;
    border-collapse: collapse;
}

.ui-datepicker-wrapper .ui-datepicker-body th,
.ui-datepicker-wrapper .ui-datepicker-body td {
    height: 34px;
    text-align: center;
}

.ui-datepicker-wrapper .ui-datepicker-body th {
    font-size: 14px;
    height: 40px;
    line-height: 40px;
}

.ui-datepicker-wrapper .ui-datepicker-body td {
    font-size: 14px;
    cursor: pointer;
    transition: all .5s;
}

.ui-datepicker-wrapper .ui-datepicker-body td.otherMonthDate {
    color: rgba(0, 0, 0, .54);
}

.ui-datepicker-wrapper .ui-datepicker-body td.active {
    color: #fff;
    background-color: #F02D29;
}

.fade-enter-active,
.fade-leave-active {
    transition: opacity .3s;
}

.fade-enter,
.fade-leave-to {
    opacity: 0;
}
</style>


