�}�Z �
  ��Q�����u
��� �dťڜ=�#��r�.	t�%�SYtUT��J����ĸS�UG
R}�&��V��6�N%��ɹ��V�!Ej9��Xx���oڀ3Gp�0�.[kҭ*Y.���a�.'dr�/{n�Y�����^A��+#k��*�Sp:��k�xN�5���'��5�^`��j������/�t�����ؙ��t��Y�0գrtp�T���>?�vѰo��s��EXOCѱ�9Hj�B[����A��y�֯�Σr�����v;)u�?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hactory);
    }
    
    @Bean
    public ClientHttpRequestFactory simpleClientHttpRequestFactory(){
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setReadTimeout(5000);//ms
        factory.setConnectTimeout(15000);//ms
        return factory;
    }
}
