�}OZ �
  63IxTUm��u
��	�d%e*�<�?�5 bB=��j w����W��Gs��[���ߔ~�0hD�9���;Q��I��mZ/۶�x����u��K�A�.��oy���ѱ���z~�l'R4�w�e�0-q�����#Wռ	sv�yd�𰫄6�!����x�V�[L��R1� ��_���S6�u��Q�-ݭ���9�Fշ�`�T�G��O�$e��n�!��
��}>���@�Uj���<�חn��J���77��}�R�K���G��d�KB��ꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'h ProductBomTechnicsServiceImpl implements IProductBomTechnicsService {

	@Autowired
	private ProductBomTechnicsMapper productBomTechnicsMapper;
	
	@Override
	public List<ProductBomTechnics> findBomTechnicsInfo(Map<String, Object> parameterMap) {
		return productBomTechnicsMapper.findBomTechnicsInfo(parameterMap);
	}

}
