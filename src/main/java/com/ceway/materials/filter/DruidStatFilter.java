�}�Z �
  KU�[S����u
��� �dդV�}�#��ݱ���Ѯ��a8�d���eм΋�+m����3��7�,5d�*�/DϮ����")� J#E#M�tVɃ]E�(��F\���1���L(���*0j��x^tF�3j����!l�� R���-
I�;f�G���P��,�b(=�<��%0��t�����8���f�3ǧ��P�j"�N�'��W�W<5cn(%��ѱ�9Hj�B[����A��y�֯�Σr�����v;)u�?3X����ׁꦋP�7��,��W���\@OyA`b��z�Y�؋੕/X�-�K�SnF�0�����q�H��:an��mZt� �[����J��?�T��݆ݗz,�;q���%�U!@�nzi�+bϢ���@�-w+���|�D�ƶ��z,!��P��=Ӳ�
��>���N0e/	���G�q���w�o��8�P4]���+r�y��F�'hhttp.WebStatFilter;

/**
 * Druid的StatFilter
 *
 * @author   单红宇(365384722)
 * @myblog  http://blog.csdn.net/catoop/
 * @create    2016年3月17日 
 */
@WebFilter(filterName="druidWebStatFilter",urlPatterns="/*",
    initParams={
        @WebInitParam(name="exclusions",value="*.js,*.gif,*.jpg,*.bmp,*.png,*.css,*.ico,/druid/*")// 忽略资源
})
public class DruidStatFilter extends WebStatFilter {

}