�}�Z �
  g�S�߽��u
��;�dťָ<�?����D�7���V/�S�� ���Pp���B��M9���]��,�"�D�� �ء��&ubx{����e-��c�<˨�Io�h,;?�R��J��Mv�	ks(}�ů�1��&�;�Љ��($6J4�橑7\.�zU���wu�\�r�ߵ�a�A�իa�U�8+0�Î�����L�\K80D�u��7ByBR�a�Hދ>kwrC�G��#� r�|��!Xǎ���_A�2�������K�fmm/���gÆ��?2␑��&pS)3_G�Y�:��kv�ِ#	.��
��>*yo�Ze���*R�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'ham map
	 * @return
	 */
	public int findStockInfoCount(Map<String, Object> map);
	
	/**
	 * 批量修改
	 * @return
	 */
	public Map<String, Object> udpateNumByList(List<Stock> list);
	
	/**
	 * 根据ID查询库存数据
	 * @param gid
	 * @return
	 */
	public Stock findStockInfoById(String gid);
	
	/**
	 * 根据ID更新库存数量
	 * @param gid
	 * @param num
	 */
	public Map<String, Object> udpateNumById(String gid,String num);
}
