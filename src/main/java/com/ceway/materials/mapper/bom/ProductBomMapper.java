�}4Z �
  ^�η�˿��u
���ds}W<��`MP7�������o�����:��i�c$�\�_�h'�fs3;1��<�@�Tّ�`?�!Ʀ�Z�ɮ֥W\@�zBKq�ڼ�{�_J�^�0ῳL���;-�G�����}`|��n�E�hߙ�U��FL.���N"�YK���*�S�h��ꥍ��5�<v�U��p�1z�?Fհ�"�j���� �BØ��k�T��'�rYzp��!��B��Ly��S3[��������_��0�� �D�/���P�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hlD+�u��8U���S&�2C̊nr7�0)~��"���ΩM#V�N���.�� ��YUW�^�ZeG�ˀ���5��1�RV�3ZDyS�eA�p������)N�)=�-�gdn�]�x�)�V􀂥�l3�鯼�^��%k����AM�a��	<;�T�ꮄ
�xu�4�7���3��X}��3�~�o�9��G���NG��c���{�,��c�����ڋKI4�6�"7�q43�h��-G�ۃH�8�?������MO�r�v4���y�B~�V�fi��"�oJ����_+I��#�p@��Z�L-]�&�h����=f�˃�o.�8��V�G�4��T�/�Z�$pѫ�f�'1Y�-�xqB�z���f�n��{~%�y���K*�u��+����k2��,F���x�.EõPt�ᦜ�<c_gw�V/������o
����/���_�45�q�̐m�Z�t��X���;Ha���54ʪR֪F{2�s�O����/D��&G>�mrg> getProductBomTree(String productBomId);
	
	/**
	 * 删除该BOM的所有子级包括该BOM
	 */
	Integer deleteProductBomTree(List<String> ids);
	
	/**
	 * 查询BOM的行数
	 * @param parameterMap
	 * @return
	 */
	Integer findProductBomByCount(Map<String, Object> parameterMap);
}
