�}fZ �
  ��J��^:��u
��� �dͤ&�<�#�o��ڞ�X��Ԅw��_z�rw�8���.�7X�`�/~����S����>_.��*��32ca�Uu�z��o����b�&W���6�1�h�xPZ`���*�Ňv]�ꭅ����{3�A�p�r��� �o�����0�c|j�gp��FX�Z�B�~��(�Q����kU�^>)&��~�Q�D(pOm��)��b���\��]s�
T����n�i�JTV@��^\�֯�Σr�����v;)u�?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hl�-	>�d��v�jF�2V�R���O�����c�z>'	r���}�"I�6{҂.�.�[���W9pJ+l��͵m����lwyx]]��1�m�����kX��E=�48�&
OZ�;f>��lk�}O8��\�Zsymǉ\R?P�3`�m\���gJ���<�qk��ꏴ]n�֩Lߜ��b����F�L�R�_g��~A��M��Aa�O�Ph��'�W5w��3���
*��5����i(+T���z�D�xe<<$�e�nK7�����R
K��"�MbQ�]�/����g(�jî8�ˀkY�1�[$ɇ/��7��g��,��Z��T�����T�3�ߩ��V�=������k �la���`܄yH�CQ0�|�rV�so*|}����O��W##��Ѡ	iy&�p���Jl�S�U���٭)c�t6%�,�)�U''R��F�m"���dY���,��f�L��?�#<85���l�1���LM�T��BB��oȼ���~?�f�a", obj.toString());
		body.add("enckey", "");*/
		body.add("realName", userName);
		body.add("loginName", userId);
		HttpSession session = request.getSession();
		MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
		headers.add("Authorization", "bearer " + session.getAttribute("token").toString());
		HttpEntity<Object> httpentity = new HttpEntity<Object>(body, headers);
		String str = restTemplate.postForObject(template, httpentity, String.class);
		return str;
	}
}
