�}1Z �
  �ѫ2�-�k��u
��� �dդZ�=�#]�|�������Wy�$� x�]�����V�N��w�)���	�\����Jlɼ)�#ȝ�Ͳ���
�nB����]�%jx��b�^P"��!��g�$�d���O�_\|����zW���:�C�EG�}VQ!L9f������b	.�dW�8W`���Q�O�&{3@�'e�3�Y��Z8j��e��Cc��mh�tW<5cn(%��ѱ�9Hj�B[����A��y�֯�Σr�����v;)u�?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hl2�
^���&���[][�Rn�4:Gg���B]G9����5r����ݡ��P5�[)s(I���y�M����2ms�n+�,�k����-*٧q'̈5�5�9}3��D\��|�}�)qztW3�?iZ{0Ʉ~؎l��F"ѫ4�^Z�*_�@J�d^�΄�?�ؤ��� Cض�i+�\tP����e���$�?�zt��O-�Ly�%J|_X���e^>���p|�u#����2�T���/m���٩����M��	��X�D$~\Ѩt|D��E�T;s� ��p["k�Y����<~`ȕ� ��������d����}G������~���h o\�դ�;�_	���OM���{���3�~�����⟻E��5�����2��<
&*� �u���VgI�Z�t=�b�֛�uz˙�f�Qx�T�P��u1�@��ۏ�.��4���䨆�[�ү:b��J�����!�?���Y���HG& />~��H�-zl�*�����2S�Omq�C'�wN��aӂQ�p�R �Hg��YK>R���f;6�Rp; ���I3[öpx�TMh�H����&`�@�{}
�</��W�V t��̊�_���f�-�^��P��Z���ӳ�򬣎�m�P?��nk�|Ǚ
�Ȼ�>B[�NA���b+B�za�TT�O><���z,=l[=v�SD�e�	Xq�d[f���\��P�>>.�X����#��[�3 ����c4#v���G4�(�nw�0!���7c�;��*pVS�?�j�#�z��w/&�|�H}����IC�,��������'P���y�!�~���k�p�=1��g�j��(��M� �T#'B�
Ӆo ��Ӊ#`�9?�*��`(i#���=F�.;��a�� ������4�iW�Ga�l|{j�����̾x#s:�zTZ����=Z�tc����`K��V �s��Է���ef�ld ��GR�Xz�:$�rԕ57sE�bN}S/��\��k�qu������put("status", "-1");
			map.put("message", "该属性已存在");
		}
		return map;
	}

	@Override
	public List<Property> findPropertyInfo(String prodCateId) {
		return propertyMapper.findPropertyInfo(prodCateId);
	}

	@Override
	public List<CategoryProperty> findPropertyByIds(Map<String, Object> parameterMap) {
		return propertyMapper.findPropertyByIds(parameterMap);
	}
}
