�}�Z �
  XngJ�.,��u
��� �dťZ�<�#]Ͻ�D[K�,ϐ���U��jt��Y�q��HO}�N`�(S�������#kA>I^ܜ̾ώ�2���ٙ�F�o����b�e+�t�2:t��Qtߓ�}x�����/��� 	�Ò��vY���#`튧�������6.��aڒ�j �g(��S�g^�Cl�<ϲ���
�k�"�S��.Y���/q��L$�&R¬�7�����T�����"�ln����y�֯�Σr�����v;)u�?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hAutowired
	private ISysLogService sysLogService;
	
	@RequestMapping("/findsysLogInfo.do")
	@ResponseBody
	public List<SysLog> findsysLogInfo(){
		List<SysLog> list = sysLogService.findsysLogInfo();
		return list;
	}
	
}
