�}Z �
  }P�ӄ���u
��� �dŤZ�=�#]ﱱ���&��֏�&�b�%�Z*$d\S2��Sj)���޻���v��&��e�TA�+����N禈�h�L�W]}*��k���%#4=��:�����3�cW�"���$�܉2<uT]����H���X�uK.'�u��[Z'���*�,�Д��&K���@��uC:�Q$T:��`[Z���{��b0��jN6�k�æn(%��ѱ�9Hj�B[����A��y�֯�Σr�����v;)u�?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hl5*��t��;��1� 5 ��Ā��qcS/��E;�+	�b.��#�&�)����?p_/��J��$���������<���ć�T�:H�.�#�k����1�iQ>�mJd(��$)���sH^fa���@=���[�N�N=J�\�L����5v��Cqs��e �ݓg ��������p��q�����92�<�R��l��[U�%_��y�(�%X�����\�wI��I��8�J�O���5z<{Z�ϧ��}Wc9����� �H��V���y���b)������<4�_lǇ$l�@P�b����*� �,�7�����}PTU^9��}J����o�H~�iɻ����EF��׳c�pnL��_�ɳ!����S&V�[�Sen�.�GAB�@s�r7��V	�17!�'e9g����(1�G���{b�ݓ��t7�;�?��-�)L$��#��&vA�;����%�C�Ty$�c�֠*D�)>?���蠀\R��l�z�f��<8�y�OetRequest request, HttpServletResponse responsel){
		Storage storage = new Storage();
		storage.setStorageName(ReqUtil.getString(request, "storageName", ""));
		storage.setStorageCode(ReqUtil.getString(request, "storageCode", ""));
		return storageService.addStorageInfo(storage);
	}
	
	
}
