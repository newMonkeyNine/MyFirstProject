�}�Z   e����	!��u
��8�d��*���;������2݅���9�cp΢�(l��ysBy7\�:��%�/�,h.�4��!x3��yhP_s`x��j�Ŕ����E����sy5��ѭ�g�$��C���r�}F�޷]#�ө�1����5y�IS7Kg���uɩ�ܳ�d�]��G�`U�ޢ��tO&��R��*�o����Ob�J�%BƊS<O��nz��� í٥��%��x{P=�����ۘV��Q$(���֯t+o�'��v+ ��S�k���~�%N�.���3��`B�Q����$u�P���'2̎��<Wմ�9�zv1B�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hl�(O��}IӈXb[E؏-ۖm�q\�%&R��#7�ϑ�D	�%k�>������e~E鍱�"�/�H9h���q{�\����9J\���Y`8�g�Y�,����kp~_Y ���y��y^zjF�!��޼�CO����=�-�K*�Pމ[��}'�xS2��F�����=�pdk��L��w���x�-�sETt�C�p̅���EA�ې�c�taM��Ŝ�Y�_%���C��V&�շ�����~��pbO.է�9d���ş�W�>�Usf�q{�2�1v�4E'��e�k]������8DD��J��)/M,8E�5y�����Y��]e����gkFh!�P�1���	d��ڶ�mb�
aT{�m.`SK>Љ#����oRG�I����e)',���}@���}��&�y��]V �k���5�>I�ߢ�_K���t�~�����g��k�'7x�����t���P���~v8�ߩ�4rg:�K����Tg�����B�l�*���}L��%�PE9���ٰ���;��œb7�e�.�+��e�I̚]i�[�Ol��؁ �cCA���j��K�;U�qğ<m����ci����Ӡ���M�gXiܭM���:e�X���}͑mꆀAv�����ڻ�b��eg��|xі9?�I����^����h�*�]�!����F8���8}l�������6�n@Km�nE���
:�ܫ���5�JI|f�Z~������'��t1���#e��i��䨝�0�bS9$����kD���_3*jͼj�Z�u��"jGy<Oskt2�7e�#?A�L���7�K� iv�B�e�=�Hwa�
W>��`(%��8����Ί-Z]r�@�+F4w���v5:T��������W����H����@���m����sB,4d\z5���O�2�#\C%b�w� xf��&�b|����&�1Y][j=���	�4�1c��D:�����O�T ��z�օm���D(���I.��\D���梙k�static double getDouble(ServletRequest request, String param,
			double value) {
		String temp = request.getParameter(param);
		if ((temp != null) && (!(temp.equals("")))) {
			double num = value;
			try {
				num = Double.parseDouble(temp);
			} catch (Exception localException) {
			}
			return num;
		}
		return value;
	}

	
	

}