�}�Z �
  �z��nQ�~��u
���d%�&�<�?�cx��LoE����wK�yDn����|����(Z/���/����q�YN�/ĥj�Y-��3����hQ@C,�;�p��}���q�[�p��}TR�sQji���=�L���Ͽ6����X��?�Q#�L�!�9�b��UE��ҜO7���G��Ѩ�f0��fݻ�ЄM��\GW�J�"���Mf���z(�Z�Mʟ˶��G��ި"70��]�3�e�NjMZv.�D���@��74�z g���Z&j*��s˝|�?:��P�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'heService {

	@Autowired
	private ProductLineMapper productLineMapper;
	
	@Override
	public List<ProductLine> findProductLineInfo() {
		return productLineMapper.findProductTechnicsInfo();
	}

}
