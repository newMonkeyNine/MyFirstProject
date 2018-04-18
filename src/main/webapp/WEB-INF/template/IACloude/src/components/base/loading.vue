<template>
	<div>
		<transition name="fade">
			<div class="mask" v-show="mask.isShow" v-on:click.stop="hideMask"></div>
		</transition>
		<datePicker ref="datePicker" v-bind:mask="mask.type == 'datePicker' && mask.isShow"></datePicker>
		<div class="icon icon-reload loader" v-bind:class="{ 'show': isActive }"></div>
		<transition name="fadeDialog">
			<aside class="dialog dialog-assign" v-show="mask.type == 'storehouse' && mask.isShow" v-bind:class="{ 'not-arrive': dialogAssign.isArrive }">
				<header>
					<span class="icon icon-arrow-left" v-on:click.stop="dialogAssign.isArrive = false"></span>
					<h3>指派至</h3>
					<button class="toggle-assign" type="button" v-if="dialogAssign.notArrival" v-on:click.stop="dialogAssign.isArrive = true">未到货？</button>
				</header>
				<section>
					<div class="check-group">
						<input type="radio" id="radio01" name="assign" value='project' v-model="radioValue" />
						<label class="task" for="radio01">本专案</label>

						<input type="radio" id="radio02" name="assign" value='warehouse' v-model="radioValue" />
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
		</transition>
	</div>
</template>


<script type="text/ecmascript-6">
import utils from '../../utils/utils.js'
import datePicker from './datePicker.vue'
import mixin from '../../utils/mixin.js'
export default {
	name: 'loading',
	data: function() {
		return {
			isActive: false,
			radioValue: 'project',
			mask: { isShow: false, type: '' },
			dialogAssign: { isArrive: false, notArrival: false,
							bomstatus: '', func: undefined 
						 }
		}
	},
	created: function() {
		this._dateSubscribe();
		this._loadingSubscribe();
		this._storehouseSubscribe();
	},
	methods: {
		_loadingSubscribe: function() {
			let self = this;
			this.$subscribe.listen("loading", function(isShow) {
				utils.debounce(function() {
					self.isActive = isShow;
				}, 130);
			})
		},
		_dateSubscribe: function() {
			let self = this;
			this.$subscribe.listen("datePickerMask", function(isShow, date) {
				self.eventFire();
				date = date || '';  //默认date值为'',类似于es6 function(isShow, date=''){...}
				if(date){  
					self.$refs.datePicker.restoreData(date, true);
				}
				self.mask = Object.assign({}, isShow);
			});
		},
		_storehouseSubscribe: function() {
			let self = this;
			this.$subscribe.listen("dialogMask", function(mask, dialogAssign) {
				self.eventFire();
				self.mask = Object.assign({}, mask);
				self.dialogAssign = Object.assign({}, dialogAssign)
				//派至哪里的需要选中哪里。
				if(dialogAssign.bomstatus === '14'){
					self.radioValue = 'project';
				}else if(dialogAssign.bomstatus === '13'){
					self.radioValue = 'warehouse';
				}else{
					self.radioValue = 'project'
				}
			});
		},
		hideMask() {
			if (this.mask.type == 'datePicker') {
				this.mask.isShow = false
			}
		},
		cancel: function() {
			this.arriveMsg = false;
			this.radioValue = 'project';
			this.mask.isShow = false;
		},
		confirm: function() {
			if (this.dialogAssign.isArrive) {
				this.dialogAssign.func('12')
			} else {
				this.dialogAssign.func(this.radioValue === 'project' ? '14' : '13')
			}
			this.cancel();
		},
		//解决选择下拉框，再选择时间,将会触发section点击事件,来至 base/routerView.vue
		eventFire: function() {
            var etype = 'click';
            var el = document.querySelector('section');
            if (el.fireEvent) {
                el.fireEvent('on' + etype);
            } else {
                var evObj = document.createEvent('Events');
                evObj.initEvent(etype, true, false);
                el.dispatchEvent(evObj);
            }
        }
	},
	components: {
		datePicker: datePicker
	},
	destroyed: function() {
		this.$subscribe.remove("loading");
		this.$subscribe.remove("dialogMask");
		this.$subscribe.remove("datePickerMask");
	}
}
</script>
<style type="text/css">
.icon.con-reload.loader {
	display: inline-block;
	font-size: 1.5rem;
	color: rgba(142, 142, 147, 0.65);
	text-align: center;
}

.loader {
	position: fixed;
	transition: 100ms;
	width: 2.5rem;
	height: 2.5rem;
	top: 6rem;
	left: 50%;
	color: #F02D29;
	text-align: center;
	line-height: 2.5rem;
	box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.1);
	border-radius: 50%;
	transform-origin: center;
	background-color: #fff;
	z-index: 9;
	margin-left: -1rem;
	display: none;
}

@keyframes spiner {
	0% {
		transform: rotate(0deg);
	}
	100% {
		transform: rotate(360deg);
	}
}

.loader.show {
	display: block;
	animation: spiner 1s infinite linear;
}

.fade-enter-active,.fade-leave-active,
.fadeDialog-enter-active,.fadeDialog-leave-active {
	transition: opacity .3s
}

.fade-enter,.fade-leave-to,
.fadeDialog-enter,.fadeDialog-leave-to {
	opacity: 0
}
</style>


