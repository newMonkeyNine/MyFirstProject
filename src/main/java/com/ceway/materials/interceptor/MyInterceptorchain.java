�}�Z �
  �'eS���u
���d������#��j�D�'&�'��P��2𘨍��Y4Ɲ��<k�� �H�/DI��82�W��ֳ�XW��/)��X4���%=���0�G!|*{$#Z]�c����[�~�论2��7|�P�
��g�A���_����bq��Q���:);�y�~��h����/�-��Z�BU�#���� ,����}*��t
t�*v�h�)2J�uJ,����F��:�]��8(v6�ȑi�CP}L�yn����L������ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'h拦截器链
        // addPathPatterns 用于添加拦截规则
		HandlerInterceptor loginInterceptor =  new LoginInterceptor();
        // excludePathPatterns 用户排除拦截
		registry.addInterceptor(loginInterceptor).addPathPatterns("/**").excludePathPatterns("/loginController/**","/sysLogController/**","/bomController/**","/selectionProductController/toDownChrome.do");         
		super.addInterceptors(registry);
    }
}
