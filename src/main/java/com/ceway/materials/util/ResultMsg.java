�}�Z   ����4�i��u
���d-�Ը��?�פ�.a��֎��ߪNp��n����8��=1~�"H�-���Zr��k|��s3��*c3���- m{����I�e���p0|M�!�F�A���+^��L����lE��!<V>k.c����}����;+���[���^��kHV�>ȶ����:Çc"hO�����A!��N��Wć��#?#WȦ��]��ĶR�1�-�]k��D��E�A-"�5�&C��T�U�Ԧ������*�]�LA�i�~*�3Y��Kg>2g�+�Q�Ώ�Z#�l\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'h
    public void setCode(int code) {  
        this.code = code;  
    }
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}  
    
	@Override
	public String toString() {
		JSONObject jo = JSONObject.fromObject(this);
		return jo.toString();
	}
}
