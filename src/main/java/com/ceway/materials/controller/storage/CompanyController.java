�}�Z �
  X��F~B����u
��� �dŤZ���#]�l�g%�7)��Q�;4[�\@��&���ʂ�&Ʈ`��\�6�
p����c�#�0[�8�;�-6;T�\�Q/߃8U���c�l$�A����K#T�j���	�R����Xc-�����kdd6Kiď�i��t�49�z�kr�"�M���*	S@�w&=f<Pt[�ߓ�nxd�t�a+�4�ՙ_�ե����tb�F��[�!��ѱ�9Hj�B[����A��y�֯�Σr�����v;)u�?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hlD4,�MWW0��<,����[�̩��������FOӿ��Tl��^�*n>�|9��M�S���x͝�&�&ʺKǓ���2
���1�$��]ܰ���퉛��N�	ƫ�|��(�Ҥ��S�8�KEz�����)��-m]�����g��\|���gb"N<�0��O��'��$y��<�8a�ۑ�2l������BI�� ��u�}�U�� �T�6*��u���oF�e���l����2 ��ttnk�����|nφ:WB�Sދ�.Y���ܻ��y:�݉�PK��XKC��?N�����@��&�C�>Z��9k �y'���s����NIx*q�S���*�����N�ʇ�t���v�r��U�o¾b���w�H�*l��w���fV׆�-�/W�-/���k#'�Q+�F�gPw(���@����\/����!Vo�ʙ�ST�MEJ2��R�6oh���-SH}f�9�ޗ�c��E��7#�ResponseBody
	public Map<String, Object> addCompanyInfo(HttpServletRequest request,HttpServletResponse responsel){
		Company company = new Company();
		company.setComporyName(ReqUtil.getString(request, "comporyName", ""));
		company.setComporyCode(ReqUtil.getString(request, "comporyCode", ""));
		company.setSortNo(ReqUtil.getInt(request, "sortNo", 0));
		return companyService.addCompanyInfo(company);
	}
}
