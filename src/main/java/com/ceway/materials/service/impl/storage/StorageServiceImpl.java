�}�Z �
  ?�6\C��d��u
��� �d%�*�<�?]c�Ӛ/˲w3���:}a����Xw��we��ݷؖ��QK?w(��qEM~�$^��䗨�����r�g���#L��K;��[� ���'b��������+��+��{��e d"@X	c2��i��\BdH餪�M^Ss�ѥE�12���]�] ���6M��xXp��<$�|�刹B�ߛ��&N�"@����� 2=�g;m���WA46��T_ʖ��o1����#��]S���v;)u�?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hl�*������T��,�ԉo;GL��
gY��@Oب��xV<����[z�-H(���|�iZF,��Գfx� j�ŗUl�28r"{zƓ��|?��D�v��'�	��_F�>���ϐ��y/�Z�DF���+ h�Di�BM8�_�V���ݳ��d.��,]ۓ���`/�%���B�za�W�!<���`3%v�t,�d�Eo�zFl਒9��/�CQU�n����C��?�x�쟨�cIk&J@��� u��tg�lr��0.�>~��m-4q�B��%�t��N4%&�/�";�Źx���'�g&p?5Gub��K��3��+�S�����gL�p�a�U��eM���\�{i�UO���n���'!�-,�E��c>zj���y7h��g�M� 6ÓLs-��'Xt�+�e�ʎ�����\w9�\L�z���2�����x���U��>����+h��������@�� �ʁS�`R����o0�I[W�hD���6��%ݯ(count <= 0) {
			storage.setGid(StringUtil.getGid());
			storage.setCreateDate(new Date());
			storage.setDelFlag(0);
			int num = storageMapper.addStorageInfo(storage);
			if (num > 0) {
				map.put("status", "1");
				map.put("message", "仓库信息添加成功");
			} else {
				map.put("status", "-1");
				map.put("message", "仓库信息添加失败");
			}
		} else {
			map.put("status", "-1");
			map.put("message", "仓库已存在");
		}
		return map;
	}

}
