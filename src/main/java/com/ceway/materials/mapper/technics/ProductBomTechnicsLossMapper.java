�}�Z �
  ���1E����u
���ds}W<��`MP7�������o�����:��i�c$�\6���8�A�1������O'�c ��0����|����w$E��%,,5_��TU���cvFя�X��0|�ө��A�N񯃮s�Ѡ��$/Wf�>�f*m�+���?y��
���`G��y�7(���5/�$Ř�0�(��
�M����������D�C��U	����X^������Ym��;��p��G�d�q�p��,*�o*[�)N��=�FIUZ�����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hicss);
	
	
	/**
	 * 根据工序ID，查询工序下耗材的信息
	 * @param opId
	 * @return
	 */
	List<ProductBomTechnicsLoss> findTechnicsLoss(String opId);
	
	/**
	 * 修改工序下的耗材信息
	 * @param technicss
	 * @return
	 */
	Integer updateTechnicsLoss(List<ProductBomTechnicsLoss> technicss);
	
	/**
	 * 修改工序单价
	 * @param technics
	 * @return
	 */
	Integer updateOpPrice(ProductBomTechnics technics);
}
