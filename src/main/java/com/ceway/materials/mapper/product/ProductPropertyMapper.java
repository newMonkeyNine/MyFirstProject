�}�Z �
  �G�ϲ����u
�� �dե��<�?�ӘDł�ᇰ���Ǽ�Ҥ�ۀ�n"�(x%����2&i��g�~Ή/j�8O�2vz�.Ѡ^x���2/2�ђ���.�WCz�`qaV#�����`�ß%���gå;�4M�J ^۝���m�I]���{�ا$@��Ed'�Z��g3c���M/8���#�n�w�����R@�+.��&��v������Z�K��wt&�ʵO[�P'�u<�vh�SP��}	Up��L?����\ԓ� ��.�e�?Lo�9���G='��=����_B ,�xOyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hl�/��D%\��O�ݮ��O2'�a�DК���Ffa`��σ%�"��*���7q��cќKꍅ���v&�	5� ���g���W` ��rpš�ކ�J�tfݿ���궭a����ś��ܛ�����ֺ L�Kc	ԊD;u���p�E��Z���?�L�Z�Iro�!J����Q\7�CC�AZ�	Y� �8A~r�r�A���	VS�z��*AV��������}�~
4
/nN����:
sT�H46C��9;!��c�8i��4�'h-3�}@�����f{��Ӥ+5w�z�͕c�W"� q�V�&8m����H�A{Jx_�iB��ۻ���E�A���Ul�V�\?��G�R�L��9�XA�d{��5����n��w��#���N��T���*,6b����4���X�?a��2L6q��5��q��ru �H�$�o�H��h5i���K����޶��l}�&b&0�B�:��)�w���Mk����j��xP�+�S�]N��a07?�-3V�g�J���Tf�Kl�"@D��(�D��\T	�̲oR-DS��/�o���lc	r�-}Z�С�%�~ a�wk.��ǼrQ�J��$��E��?-w�az倬�Q>��
Ċ5��S_V�,���\��hՀ��x&A�G,jʰ�t���V�.��qd-@�,��h�Tw<LO�l9��k{���R�f��;���XU�±UP���[��m�`�/}i���]*��� �T�fZ1ǉM���9v�E����9�*�9�;�>"R����f�2��H�](�;��A���V�P;�H<NUC�̭��{�h9��5.�<!w�>�`�]�(XR��P%�o�v-D\(P_>_59�|�!�ɋ�54*4�J'^�Z:?ˑ��v��^�����TMeI6��C2�n��Bj��c'=FHQ���7X��q�-8��ARkd��3�E|�~��EwM=����8H�9%R���^�|�F�ixŕt]{;z_-x��sO����L͖G�5Hɡ����/X�i��+�b=l+z�O8��K�k3ͷ�ó���@r�����\XM@�1�G�<�� ��F;�*���sk�;A��^ ������h�X� �̧jL9_�1S-���#ko~�t��mqӟ���{�S��I���C�>���$�q��c����S-��h����ZRqw��K �,RK��d�kء�-b9�<LkJ�~}��c���t-,�����=��%Z��r�`$P�G�D��#�ܟU�f����=�$E��h�zW��K��/MX����k^8�&��Cf�!^tKL�[xd��{,��	��0UZ$4�»��=�o+��0�oX��d���,��Z��Xȩ=���YHyJ^�#�7g6�*�E�L�w��W^b�!Dު%���K�|�k�Ԫ&3�4tc �Rx�������.��ᛕ���&�yҟ�*�AO4��]5�C�>��i�_%�	�b�3BwZۮ�9����i�.��[X��GBl}-��~dW⮳��#%�����[u��zH,��$�z��	(EditPropertyNameIsExits(@Param("name")String name,@Param("cateId")String cateId,@Param("propId")String propId);

	/**
	 * 修改时查询规格是否存在
	 * @return
	 */
	public int findSortNoIsExits(@Param("sortNo")Integer sortNo,@Param("cateId")String cateId,@Param("propId")String propId);


	/**
	 * 删除规格大类时删除属性值
	 */
	public int deletePropertyValueById(String id);

}
