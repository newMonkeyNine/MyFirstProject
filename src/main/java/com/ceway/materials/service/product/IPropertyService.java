�}*Z �
  @�M�*���u
��5�d�dи<�;E?i�\�-�g0k�p;��|��x�b�(<��=��v�g�8�� ,w^��|�t٭9�D�<���������oH	,��2�XX�O�_۰n�7H;J���d����VϴW�DK��������W��$έ�xM�6D��(/��$!ٱF]��[F}d��� >$�s��7 :�&��]�]nd����YjԽ'���x}[���4�F��=�3e%]�ť��t'U劉cUV5���4���酔!�$���ğ� XTyq豓�N,��M��-��8�Bv�v!�R�X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hect> parameterMap);
	
	/**
	 * 添加产品属性
	 * @param property
	 * @return
	 */
	public Map<String, Object> addPropertyInfo(Property property);
	
	/**
	 * 查询所有属性
	 * @return
	 */
	public List<Property> findPropertyInfo(String prodCateId);
	
	/**
	 * 根据ID集合查询对应的属性
	 * @param parameterMap
	 * @return
	 */
	public List<CategoryProperty> findPropertyByIds(Map<String, Object> parameterMap);
	
	
}
