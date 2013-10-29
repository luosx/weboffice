
//实现一个栈，用来保存季度的修改信息
var Stack = function(){};
Stack.prototype={
	Init:function(){
		this.STACKMAX = 100;
		this.stack = new Array(this.STACKMAX);
		this.top = -1;
		return this.stack;
	},
	Empty:function(){
		if(this.top == -1){
			return true;
		}else{
			return false;
		}
	},
	Push:function(elem){
		if(this.top == this.STACKMAX - 1){
			return "full";
		}else{
			this.top++;
			this.stack[this.top] = elem;
		}
	},
	Pop:function(){
		if(this.top == -1){
			return "empty";
		}
		else{
			var x = this.stack[this.top];
			this.top--;
			return x;
		}
	},
	Top:function(){
		if(this.Top != -1){
			return this.stack[this.top];
		}else{
			return "empty";
		}
	},
	Clear:function(){
		this.top = -1;
	},
	Length:function(){
		return this.top + 1;
	}
}