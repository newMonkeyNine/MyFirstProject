�}IZ �
  ��39��c��u
��� �d%�ڜ=�#����Z�g��Y��'��k�� M�2/�v��q�Kq��E_��Ϥ*��oO}���ȵ~A󔴰�+�R�u���n����* c���N�0=�:�Zzy�ʲ�2b��0k���k�.�:�A�38HEg�F�}B
|�#�7�z Sj���$�k�}{� �g����rDxA����ĩW!��G��Lt��`��=ҏ)���ꦄt���Z��#��Gv���� L u�G�;\r���ύ�v;)u�?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hl�!�8X�u8��ǩ�lA�:��yϔ��o�~�ɩ�5�h>Y_ $W,^d|6��Y��/^�[fI���p�4鏮���09O���y5v���1	�G��&�j����v�.��3ѴD+>��,��)%fMu�zq���n��N|.�Wo<�vu�箓ͅ���4|�"�u�F�-�P�Z�mD�]%��ARe	�81\>�IEra��4��W�P���3���Bv��~��ϔ3�y��3k�U��BZ�\�Z��6 �e�YU� սغ�y@?;��S�2{�N�v�IW�Oc�b�DLO����ۼ�m[���(�l��݋���"����U����xH}������@���9_	� ��@@�ӬdRW����;YMk��c��%��T��.|x�ļv�>���(6x��De�.��$��2�~3�~&w���|�l��N��wG9hn�"l�1����C5�I��[c�X�.ڦ���*���{uGS��	y %M{k/�}K�5	�l.b%��}�EG�6�Cw����NwJ�&���K�'S�3s� �!�+����p���~�`�a�#<���qz�0��YJVoH
^b�������W�6P�5X�!�Ρ�d�KB�~�F��rQ�X�bws��-�м�)���&��8k�{#�V�|Ǒtʗ��� #��y��֘_������$��%y��<D��dʷ�$��T� ����(ac�>m�T��&A6cl;�Q��	$��SY?D����n����C�ךхN��f��|ݨ�"7h�Q	n=lc��Ag��$t����Z����u���;k}8�'5 � N&�y$2���)���z�j���;F(��<y�k�m��D��~��b����S�i�Mw��=���j�:�P9/t��g��k��$N���c��^j�%�\B&��BOsT>bb�D���EFN��9�]��b�R�Lnl
���`�����@�Sf ��68��9] -%!�V&��YB��g64����b��a�Kl2�,�,"�R{%�Op߁���k��|��u<���>���_bk����d�}8��+Uj*gS��r6�)Nm�s6a<��w����8W��u��������fQwJ@x1�jC�W[9�Nf�b�^���)p9Pjw[L���~� 	�Ӫ��l�|�	B��ө؟��o֘,�љVJO��Q\s9����;�®dw����$�?^���p8���T�˳�ۢz��,Y�� �]�>��s��\mN� ނZ	.��/e�"�=縲����u
��u�ҮG�SB��ioM��T�9g#X��Ϸz"m�T����;"fI���%���WA��޴%�b����mq���� ��k���{ .��¿G;�\S���DX����?���q�M?#*io@�vL��Nۡ�q�'��9��R���bI�|�i9�����3WN���!��*�Y��,J�Ϡ���2 u�DL����贙�A)�M󪶷�w�Ȍ�������#Q��!'�q�yU�ML�Yl�)v��|��C78�e-qH1��ي���&,%��z�,d��2�ȐV];- 0�0�����^W��Be��6�X����K���4�DF���x�@��CH˯#��,)ѕB��~�%� �
R$�^�:91�!�C�09�<M�����ɚ��"#9��F�2�$���t�o��q~>a��Xo���H�qۤy͗~Bn�=�)s٣�w���ܹ7՘�{!�R�=��J��q��Iǚ����^���!Aו��$�xw�z"w���N�Sﴞ��̼���	eH���[I���]�+�C�W.�?C*X$�}��+�<r�!�1���hŜeX���q��W��P��i�z[=��L5ʩ!�|��������;ij�p�=Zq�.�$�LR�%~O.��j�=?%\g�j$uy�������x��V��no�yװ�K��LS��e�ZlV���ܯ�� Z�i�Ҽ�kX[������A��V������ZVj�^�);
		for (Map.Entry<String, List<ProductBO>> entry : returnMap.entrySet()) {
			exportExcel.exportExcel(workbook, i, entry.getKey(), headers,
					entry.getValue(), outputStream);
			i++;
		}
		try {
			workbook.write(outputStream);
		} catch (Exception e) {
			LOG.error("导出物料信息抛异常", e.getMessage());
			e.printStackTrace();
			resultMap.put("status", -1);
		} finally {
			outputStream.close();
			outputStream.flush();
		}
	}
}