�}�Z   ���^@X��u
��0�d5d@�=�?���6��A'���_�.��M� ��v���2�+�bU��5�(<V�����W0�~n>��,@��-�30E�a�{�{���n@bn��� �0��l��J�u�����Ϸ2��*_'�{ȓȪ���.yo�_#/
�oV[�x�� �b�zE���Y��5뭟udx���k@=�����+i/~�ܤ�ٽH/������hn�=�g1Z�����1�V�S����G'�~n����X��m^��_�ʕYd�ؑ��5~-z3����>"n�'{u�ٚKWF�4�	��)�ۘo���q)੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hce();
		}
		String loginName = (String) request.getSession().getAttribute("loginName");
		bean.setCreateId(loginName);
		bean.setCreateDate(new Date());
		bean.setGid(StringUtil.getGid());
		return bean;
	}
}
