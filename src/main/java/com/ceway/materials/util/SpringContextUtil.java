�}�Z   \����v���u
��� �d����<�;�����/���k_;n�/Ɉ����.s/�/� ���� ��v��`�蕺��z�n'�\���=t����������$�S���%WzS?�P'�;���O���tt�4�׉W����ּji��3�{��]!������Ͳ�&��Ѓq]N;�����z-1R�4����8����5�(����_E�a;$�d�m5DMY��c���T�JwK�x4��֮"���1��P���Y�3�E�1��l��!��?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hl�.��Bc�!If��;ʊ��擳@	��4��Z��u��؟�Ʌl#I6����y�\����!�t��osإ��;���B���Dl�C�\��:�ѳo��-dF���WQ��E�Q�N��6�J�l�v���"&��m��P�"�)�T����� l'�!@�K����L����џ�cN�`�R֘,$n�Fc�N�`�vFW{���,����Yp(_-=M�ze�Cӭ�����vs�@X���c��G#�i}m�hz����{e/�O�O[M}�F%�:;���f"���GGJ�b���x-��v����f���Ϊ�p��=���A!߰(}90\6�/>Mt漵G9�6�������4X�Dg��~Y���(K�P��Ȩ��7fD�L�_��p�uD�u�8��a��̟ ��ұ��ܹ����'Ǌ��+�Nk�h�/��:�^�,~�_�n}#�1/��+Y�SL���U������Ls�Cಘ�Rצ��-�6V4k0n.�������LO�ontext = applicationContext;
	}

	public static ApplicationContext getApplicationContext() {
		return applicationContext;
	}

	@SuppressWarnings("unchecked")
	public static <T> T getBean(String name) throws BeansException {
		return (T) applicationContext.getBean(name);
	}

	public static <T> T getBean(Class<T> clazz) throws BeansException {
		return (T) applicationContext.getBean(clazz);
	}
}