�}�Z �
  ��z�L-� ��u
��� �dťڜ=�#\���Z���@���T��3{k���m2��+�V�kW\>`��Hټ^K�p������2?��?�+��X�4������#
u�L]IQ�x�M| ����,��6ma��B�vpy�a0+���G�̪]�g�*R����!_�ξ>��}-���R""�S�j��caBW#-_��Z�����z:/�pV$uvDi'����ѱ�9Hj�B[����A��y�֯�Σr�����v;)u�?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hlD*|`���s�s��|����N�����������o�e��r�g{u1��$\����	��L�9y��ex���T'��A6SW����r5=[0���[®
i oͮ.!����{˃���R�0ľ���^Lˋ4���+?*���� ���8]Po����/��߇�,s��Z�!��,<Y 8�󮒡�����Z��'���<�s"�L�#{�P	r�1���g�Z�{;6���2R2j��R0�י�唀��f~c���n ���[���:O�xsP0M��fN�e/>�3R��2��cG"�I�Wb\um��Հ~�N�ǋ�T��}I"̶-�D�%F}>�Rd@y�?����}a����8O#nu4QRU�*T��l��ꛥBXF��F�F*;.�_�7�	�;��u�F);Vl"/���}�d����:���⾒�t��.:�P���=>G�<����[�d���c����](x]� pRxm������g@��"/0sponse responsel) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Category> categorys = categoryService.findCategoryInfo();
			resultMap.put("code", 200);
			resultMap.put("data", categorys);
		} catch (Exception e) {
			resultMap.put("code", 500);
			resultMap.put("msg", e.getMessage());
			LOG.error("查询物料类别信息出现异常",e.getMessage());
		}
		return resultMap;
	}
}
