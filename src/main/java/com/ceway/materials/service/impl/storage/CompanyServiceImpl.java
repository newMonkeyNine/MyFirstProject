�}SZ �
  k� -����u
��� �d%�*�<�?]c��ڒ���-w˻+9�=y�XL��}��I�[?yjF�S@�>��,�ڡA�;K����x�ƀ� Ԇ�fx��l�fӱ�_
v��JĔZ�l�Tƚx:�~���c�-R�4��"@���;�" �����ҬL䗄�ҟ4�+\��F�$!�dW�s絑���1/EF�=�)N	�7%S��J���8��/�A�^j{˫Rg��n >
z���ݼ��Iֱzmor��	�Er��dK~f�ސ�)u�?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hlD'�G����/�ޒ-׀>���I���f$6G���ݑ����ce��/C����X���?�ޗ���t� �C�-;m���v�.��*��V�Kc�!D�����['�e�f�X�&�5s��r�jWzl��(��	Sp�\���~��"��r{��\�HK{��,>t��vg�|��ᙡ]F���P"���m��ߖ������e�dB6�uŏ)ɋv���(����ɐ�(Q%�	O�1���~��,�� �i\qP�Kb�x��:l�w���g6�ɏɎ�nb%���a�B�D�t{�2�������է���6���v�X��!!��7�����;�w�)��j&3{����SI>�۵��"�.��{_=Q���S�B��N�65�x,@(���^ާ�R@����bz��U�������­�u���*�܊�o�A��}� 2)M�!�	_eط���9e�V�^�7	�;9!q�RZ�qO?ti���y(�t��J+�8W���%�#}�S�fE��y.setGid(StringUtil.getGid());
			company.setDelFlag(0);
			company.setCreateDate(new Date());
			int num = companyMapper.addCompanyInfo(company);
			if (num > 0) {
				map.put("status", "1");
				map.put("message", "公司信息添加成功");
			} else {
				map.put("status", "-1");
				map.put("message", "公司信息添加失败");
			}
		} else {
			map.put("status", "-1");
			map.put("message", "公司信息已经存在");
		}
		return map;
	}

}
