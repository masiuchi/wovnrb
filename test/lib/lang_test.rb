require 'test_helper'

module Wovnrb
  class LangTest < WovnMiniTest
    def test_langs_exist
      refute_nil(Wovnrb::Lang::LANG)
    end

    def test_langs_length
      assert_equal(39, Wovnrb::Lang::LANG.length)
    end

    def test_keys_exist
      Wovnrb::Lang::LANG.each do |k, l|
        assert(l.key?(:name))
        assert(l.key?(:code))
        assert(l.key?(:en))
        assert_equal(k, l[:code])
      end
    end

    def test_iso_639_1_normalization
      assert_equal('ar', Lang.iso_639_1_normalization('ar'))
      assert_equal('eu',       Lang.iso_639_1_normalization('eu'))
      assert_equal('bn',       Lang.iso_639_1_normalization('bn'))
      assert_equal('bg',       Lang.iso_639_1_normalization('bg'))
      assert_equal('ca',       Lang.iso_639_1_normalization('ca'))
      assert_equal('zh-Hans',  Lang.iso_639_1_normalization('zh-CHS'))
      assert_equal('zh-Hant',  Lang.iso_639_1_normalization('zh-CHT'))
      assert_equal('da',       Lang.iso_639_1_normalization('da'))
      assert_equal('nl',       Lang.iso_639_1_normalization('nl'))
      assert_equal('en',       Lang.iso_639_1_normalization('en'))
      assert_equal('fi',       Lang.iso_639_1_normalization('fi'))
      assert_equal('fr',       Lang.iso_639_1_normalization('fr'))
      assert_equal('gl',       Lang.iso_639_1_normalization('gl'))
      assert_equal('de',       Lang.iso_639_1_normalization('de'))
      assert_equal('el',       Lang.iso_639_1_normalization('el'))
      assert_equal('he',       Lang.iso_639_1_normalization('he'))
      assert_equal('hu',       Lang.iso_639_1_normalization('hu'))
      assert_equal('id',       Lang.iso_639_1_normalization('id'))
      assert_equal('it',       Lang.iso_639_1_normalization('it'))
      assert_equal('ja',       Lang.iso_639_1_normalization('ja'))
      assert_equal('ko',       Lang.iso_639_1_normalization('ko'))
      assert_equal('lv',       Lang.iso_639_1_normalization('lv'))
      assert_equal('ms',       Lang.iso_639_1_normalization('ms'))
      assert_equal('my',       Lang.iso_639_1_normalization('my'))
      assert_equal('ne',       Lang.iso_639_1_normalization('ne'))
      assert_equal('fa',       Lang.iso_639_1_normalization('fa'))
      assert_equal('no',       Lang.iso_639_1_normalization('no'))
      assert_equal('pl',       Lang.iso_639_1_normalization('pl'))
      assert_equal('pt',       Lang.iso_639_1_normalization('pt'))
      assert_equal('ru',       Lang.iso_639_1_normalization('ru'))
      assert_equal('es',       Lang.iso_639_1_normalization('es'))
      assert_equal('sw',       Lang.iso_639_1_normalization('sw'))
      assert_equal('sv',       Lang.iso_639_1_normalization('sv'))
      assert_equal('th',       Lang.iso_639_1_normalization('th'))
      assert_equal('hi',       Lang.iso_639_1_normalization('hi'))
      assert_equal('tr',       Lang.iso_639_1_normalization('tr'))
      assert_equal('uk',       Lang.iso_639_1_normalization('uk'))
      assert_equal('ur',       Lang.iso_639_1_normalization('ur'))
      assert_equal('vi',       Lang.iso_639_1_normalization('vi'))
    end

    def test_get_code_with_valid_code
      assert_equal('ms', Wovnrb::Lang.get_code('ms'))
    end

    def test_get_code_with_capital_letters
      assert_equal('zh-CHT', Wovnrb::Lang.get_code('zh-cht'))
    end

    def test_get_code_with_valid_english_name
      assert_equal('pt', Wovnrb::Lang.get_code('Portuguese'))
    end

    def test_get_code_with_valid_native_name
      assert_equal('hi', Wovnrb::Lang.get_code('हिन्दी'))
    end

    def test_get_code_with_invalid_name
      assert_nil(Wovnrb::Lang.get_code('WOVN4LYFE'))
    end

    def test_get_code_with_empty_string
      assert_nil(Wovnrb::Lang.get_code(''))
    end

    def test_get_code_with_nil
      assert_nil(Wovnrb::Lang.get_code(nil))
    end

    def test_add_lang_code
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://www.facebook.com', lang.add_lang_code('http://www.facebook.com', 'subdomain', h))
    end

    def test_add_lang_code_relative_slash_href_url_with_path
      lang = Lang.new('fr')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://fr.wovn.io/topics/44'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://fr.wovn.io/topics/50', lang.add_lang_code('/topics/50', 'subdomain', h))
    end

    def test_add_lang_code_relative_dot_href_url_with_path
      lang = Lang.new('fr')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://fr.wovn.io/topics/44'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://fr.wovn.io/topics/44/topics/50', lang.add_lang_code('./topics/50', 'subdomain', h))
    end

    def test_add_lang_code_relative_two_dots_href_url_with_path
      lang = Lang.new('fr')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://fr.wovn.io/topics/44'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://fr.wovn.io/topics/50', lang.add_lang_code('../topics/50', 'subdomain', h))
    end

    def test_add_lang_code_trad_chinese
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://zh-cht.wovn.io/topics/31', lang.add_lang_code('http://wovn.io/topics/31', 'subdomain', h))
    end

    def test_add_lang_code_trad_chinese_2
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://zh-cht.wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://zh-cht.wovn.io/topics/31', lang.add_lang_code('/topics/31', 'subdomain', h))
    end

    def test_add_lang_code_trad_chinese_lang_in_link_already
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://zh-cht.wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://zh-cht.wovn.io/topics/31', lang.add_lang_code('http://zh-cht.wovn.io/topics/31', 'subdomain', h))
    end

    def test_add_lang_code_no_protocol
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'https://zh-cht.google.com'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('//zh-cht.google.com', lang.add_lang_code('//google.com', 'subdomain', h))
    end

    def test_add_lang_code_no_protocol_2
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'https://zh-cht.wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('//google.com', lang.add_lang_code('//google.com', 'subdomain', h))
    end

    def test_add_lang_code_invalid_url
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://www.facebook.com/sharer.php?u=http://wovn.io/topics/50&amp;amp;t=Gourmet Tofu World: Vegetarian-Friendly Japanese Food is Here!', lang.add_lang_code('http://www.facebook.com/sharer.php?u=http://wovn.io/topics/50&amp;amp;t=Gourmet Tofu World: Vegetarian-Friendly Japanese Food is Here!', 'subdomain', h))
    end

    def test_add_lang_code_path_only_with_slash
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://zh-cht.wovn.io/topics/31', lang.add_lang_code('/topics/31', 'subdomain', h))
    end

    def test_add_lang_code_path_only_no_slash
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://zh-cht.wovn.io/topics/31', lang.add_lang_code('topics/31', 'subdomain', h))
    end

    def test_add_lang_code_path_explicit_page_no_slash
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://zh-cht.wovn.io/topics/31.html', lang.add_lang_code('topics/31.html', 'subdomain', h))
    end

    def test_add_lang_code_path_explicit_page_with_slash
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://zh-cht.wovn.io/topics/31.html', lang.add_lang_code('/topics/31.html', 'subdomain', h))
    end

    def test_add_lang_code_no_protocol_with_path_explicit_page
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('//www.google.com/topics/31.php', lang.add_lang_code('//www.google.com/topics/31.php', 'subdomain', h))
    end

    def test_add_lang_code_protocol_with_path_explicit_page
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://www.google.com/topics/31.php', lang.add_lang_code('http://www.google.com/topics/31.php', 'subdomain', h))
    end

    def test_add_lang_code_relative_path_double_period
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://zh-cht.wovn.io/topics/31', lang.add_lang_code('../topics/31', 'subdomain', h))
    end

    def test_add_lang_code_relative_path_single_period
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://zh-cht.wovn.io/topics/31', lang.add_lang_code('./topics/31', 'subdomain', h))
    end

    def test_add_lang_code_empty_href
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('', lang.add_lang_code('', 'subdomain', h))
    end

    def test_add_lang_code_hash_href
      lang = Lang.new('zh-cht')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('#', lang.add_lang_code('#', 'subdomain', h))
    end

    def test_add_lang_code_nil_href
      lang = Lang.new('en')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings)
      assert_nil(lang.add_lang_code(nil, 'path', h))
    end

    def test_add_lang_code_absolute_different_host
      lang = Lang.new('fr')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com'), Wovnrb.get_settings)
      assert_equal('http://yahoo.co.jp', lang.add_lang_code('http://yahoo.co.jp', 'path', h))
    end

    def test_add_lang_code_absolute_subdomain_no_subdomain
      lang = Lang.new('fr')
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com'), Wovnrb.get_settings)
      assert_equal('http://fr.google.com', lang.add_lang_code('http://google.com', 'subdomain', h))
    end

    def test_add_lang_code_absolute_subdomain_with_subdomain
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://home.google.com'), Wovnrb.get_settings)
      assert_equal('http://fr.home.google.com', lang.add_lang_code('http://home.google.com', 'subdomain', headers))
    end

    def test_add_lang_code_with_query_and_lang_param_name
      Store.instance.update_settings('url_pattern_name' => 'query', 'lang_param_name' => 'lang')

      sut = Lang.new('fr')
      headers = Wovnrb::Headers.new(
        Wovnrb.get_env('url' => 'http://google.com'),
        Store.instance.settings
      )

      assert_equal('http://google.com?hey=yo&lang=fr', sut.add_lang_code('http://google.com?hey=yo', 'query', headers))
    end

    def test_add_lang_code_absolute_query_no_query
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com'), Wovnrb.get_settings)
      assert_equal('http://google.com?wovn=fr', lang.add_lang_code('http://google.com', 'query', headers))
    end

    def test_add_lang_code_absolute_query_with_query
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com'), Wovnrb.get_settings)
      assert_equal('http://google.com?hey=yo&wovn=fr', lang.add_lang_code('http://google.com?hey=yo', 'query', headers))
    end

    def test_add_lang_code_absolute_query_with_hash
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com'), Wovnrb.get_settings)
      assert_equal('http://google.com?wovn=fr#test', lang.add_lang_code('http://google.com#test', 'query', headers))
    end

    def test_add_lang_code_absolute_path_no_pathname
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com'), Wovnrb.get_settings)
      assert_equal('http://google.com/fr/', lang.add_lang_code('http://google.com', 'path', headers))
    end

    def test_add_lang_code_absolute_path_with_pathname
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com'), Wovnrb.get_settings)
      assert_equal('http://google.com/fr/index.html', lang.add_lang_code('http://google.com/index.html', 'path', headers))
    end

    def test_add_lang_code_absolute_path_with_long_pathname
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com'), Wovnrb.get_settings)
      assert_equal('http://google.com/fr/hello/long/path/index.html', lang.add_lang_code('http://google.com/hello/long/path/index.html', 'path', headers))
    end

    def test_add_lang_code_relative_subdomain_leading_slash
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com'), Wovnrb.get_settings)
      assert_equal('http://fr.google.com/', lang.add_lang_code('/', 'subdomain', headers))
    end

    def test_add_lang_code_relative_subdomain_leading_slash_filename
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com'), Wovnrb.get_settings)
      assert_equal('http://fr.google.com/index.html', lang.add_lang_code('/index.html', 'subdomain', headers))
    end

    def test_add_lang_code_relative_subdomain_no_leading_slash_filename
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com/'), Wovnrb.get_settings)
      assert_equal('http://fr.google.com/index.html', lang.add_lang_code('index.html', 'subdomain', headers))
    end

    def test_add_lang_code_relative_query_with_no_query
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com/'), Wovnrb.get_settings)
      assert_equal('/index.html?wovn=fr', lang.add_lang_code('/index.html', 'query', headers))
    end

    def test_add_lang_code_relative_query_with_query
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com/'), Wovnrb.get_settings)
      assert_equal('/index.html?hey=yo&wovn=fr', lang.add_lang_code('/index.html?hey=yo', 'query', headers))
    end

    def test_add_lang_code_relative_query_with_hash
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com/'), Wovnrb.get_settings)
      assert_equal('/index.html?hey=yo&wovn=fr', lang.add_lang_code('/index.html?hey=yo', 'query', headers))
    end

    def test_add_lang_code_relative_path_with_leading_slash
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com/'), Wovnrb.get_settings)
      assert_equal('/fr/index.html', lang.add_lang_code('/index.html', 'path', headers))
    end

    def test_add_lang_code_relative_path_without_leading_slash_different_pathname
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com/hello/tab.html'), Wovnrb.get_settings)
      assert_equal('/fr/hello/index.html', lang.add_lang_code('index.html', 'path', headers))
    end

    def test_add_lang_code_relative_path_without_leading_slash_different_pathname2
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com/hello/tab.html'), Wovnrb.get_settings)
      assert_equal('/fr/hello/hey/index.html', lang.add_lang_code('hey/index.html', 'path', headers))
    end

    def test_add_lang_code_relative_path_at_root
      lang = Lang.new('fr')
      headers = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://google.com/'), Wovnrb.get_settings)
      assert_equal('/fr/index.html', lang.add_lang_code('index.html', 'path', headers))
    end

    def generate_body(param = '')
      body = case param
             when 'ignore_parent'
               "<html><body><h1>Mr. Belvedere Fan Club</h1>
                     <div wovn-ignore><p>Hello</p></div>
                   </body></html>"
             when 'ignore_everything'
               "<html><body wovn-ignore><h1>Mr. Belvedere Fan Club</h1>
                     <div><p>Hello</p></div>
                   </body></html>"
             when 'ignore_parent_translated_in_japanese'
               "<html lang=\"ja\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><script src=\"//j.wovn.io/1\" async=\"true\" data-wovnio=\"key=&amp;backend=true&amp;currentLang=ja&amp;defaultLang=en&amp;urlPattern=path&amp;langCodeAliases={}&amp;version=#{Wovnrb::VERSION}\"> </script><link rel=\"alternate\" hreflang=\"ja\" href=\"http://ja.ignore-page.com/\"><link rel=\"alternate\" hreflang=\"en\" href=\"http://ignore-page.com/\"></head><body><h1><!--wovn-src:Mr. Belvedere Fan Club-->ベルベデアさんファンクラブ</h1>
                     <div wovn-ignore=\"\"><p>Hello</p></div>
                   </body></html>
       "
             when 'translated_in_japanese'
               "<html lang=\"ja\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><script src=\"//j.wovn.io/1\" async=\"true\" data-wovnio=\"key=&amp;backend=true&amp;currentLang=ja&amp;defaultLang=en&amp;urlPattern=path&amp;langCodeAliases={}&amp;version=#{Wovnrb::VERSION}\"> </script><link rel=\"alternate\" hreflang=\"ja\" href=\"http://ja.page.com/\"><link rel=\"alternate\" hreflang=\"en\" href=\"http://page.com/\"></head><body><h1><!--wovn-src:Mr. Belvedere Fan Club-->ベルベデアさんファンクラブ</h1>
                     <div><p><!--wovn-src:Hello-->こんにちは</p></div>
                   </body></html>
       "
             when 'ignore_everything_translated'
               "<html lang=\"ja\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><script src=\"//j.wovn.io/1\" async=\"true\" data-wovnio=\"key=&amp;backend=true&amp;currentLang=ja&amp;defaultLang=en&amp;urlPattern=path&amp;langCodeAliases={}&amp;version=#{Wovnrb::VERSION}\"> </script><link rel=\"alternate\" hreflang=\"ja\" href=\"http://ja.ignore-page.com/\"><link rel=\"alternate\" hreflang=\"en\" href=\"http://ignore-page.com/\"></head><body wovn-ignore=\"\"><h1>Mr. Belvedere Fan Club</h1>
                     <div><p>Hello</p></div>
                   </body></html>
       "
             when 'empty'
               '<html><body><h1>Mr.BelvedereFanClub</h1><div wovn-ignore><p>Hello</p></div></body></html>'
             when 'empty_single_quote'
               "<html><body><h1>Mr.BelvedereFanClub</h1><div wovn-ignore=''><p>Hello</p></div></body></html>"
             when 'empty_double_quote'
               '<html><body><h1>Mr.BelvedereFanClub</h1><div wovn-ignore=''><p>Hello</p></div></body></html>'
             when 'value_single_quote'
               "<html><body><h1>Mr.BelvedereFanClub</h1><div wovn-ignore='value'><p>Hello</p></div></body></html>"
             when 'value_double_quote'
               '<html><body><h1>Mr.BelvedereFanClub</h1><div wovn-ignore="value"><p>Hello</p></div></body></html>'
             when 'empty_translated'
               "<html lang=\"ja\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><script src=\"//j.wovn.io/1\" async=\"true\" data-wovnio=\"key=&amp;backend=true&amp;currentLang=ja&amp;defaultLang=en&amp;urlPattern=path&amp;langCodeAliases={}&amp;version=#{Wovnrb::VERSION}\"> </script><link rel=\"alternate\" hreflang=\"ja\" href=\"http://ja.ignore-page.com/\"><link rel=\"alternate\" hreflang=\"en\" href=\"http://ignore-page.com/\"></head><body><h1>Mr.BelvedereFanClub</h1><div wovn-ignore=\"\"><p>Hello</p></div></body></html>\n"
             when 'empty_single_quote_translated'
               "<html lang=\"ja\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><script src=\"//j.wovn.io/1\" async=\"true\" data-wovnio=\"key=&amp;backend=true&amp;currentLang=ja&amp;defaultLang=en&amp;urlPattern=path&amp;langCodeAliases={}&amp;version=#{Wovnrb::VERSION}\"> </script><link rel=\"alternate\" hreflang=\"ja\" href=\"http://ja.ignore-page.com/\"><link rel=\"alternate\" hreflang=\"en\" href=\"http://ignore-page.com/\"></head><body><h1>Mr.BelvedereFanClub</h1><div wovn-ignore=\"\"><p>Hello</p></div></body></html>\n"
             when 'empty_double_quote_translated'
               "<html lang=\"ja\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><script src=\"//j.wovn.io/1\" async=\"true\" data-wovnio=\"key=&amp;backend=true&amp;currentLang=ja&amp;defaultLang=en&amp;urlPattern=path&amp;langCodeAliases={}&amp;version=#{Wovnrb::VERSION}\"> </script><link rel=\"alternate\" hreflang=\"ja\" href=\"http://ja.ignore-page.com/\"><link rel=\"alternate\" hreflang=\"en\" href=\"http://ignore-page.com/\"></head><body><h1>Mr.BelvedereFanClub</h1><div wovn-ignore=\"\"><p>Hello</p></div></body></html>\n"
             when 'value_single_quote_translated'
               "<html lang=\"ja\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><script src=\"//j.wovn.io/1\" async=\"true\" data-wovnio=\"key=&amp;backend=true&amp;currentLang=ja&amp;defaultLang=en&amp;urlPattern=path&amp;langCodeAliases={}&amp;version=#{Wovnrb::VERSION}\"> </script><link rel=\"alternate\" hreflang=\"ja\" href=\"http://ja.ignore-page.com/\"><link rel=\"alternate\" hreflang=\"en\" href=\"http://ignore-page.com/\"></head><body><h1>Mr.BelvedereFanClub</h1><div wovn-ignore=\"value\"><p>Hello</p></div></body></html>\n"
             when 'value_double_quote_translated'
               "<html lang=\"ja\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><script src=\"//j.wovn.io/1\" async=\"true\" data-wovnio=\"key=&amp;backend=true&amp;currentLang=ja&amp;defaultLang=en&amp;urlPattern=path&amp;langCodeAliases={}&amp;version=#{Wovnrb::VERSION}\"> </script><link rel=\"alternate\" hreflang=\"ja\" href=\"http://ja.ignore-page.com/\"><link rel=\"alternate\" hreflang=\"en\" href=\"http://ignore-page.com/\"></head><body><h1>Mr.BelvedereFanClub</h1><div wovn-ignore=\"value\"><p>Hello</p></div></body></html>\n"
             when 'meta_img_alt_tags_translated'
               "<html lang=\"ja\"><head><script src=\"//j.wovn.io/1\" async=\"true\" data-wovnio=\"key=&amp;backend=true&amp;currentLang=ja&amp;defaultLang=en&amp;urlPattern=path&amp;langCodeAliases={}&amp;version=#{Wovnrb::VERSION}\"> </script><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><meta name=\"description\" content=\"こんにちは\">\n<meta name=\"title\" content=\"こんにちは\">\n<meta property=\"og:title\" content=\"こんにちは\">\n<meta property=\"og:description\" content=\"こんにちは\">\n<meta property=\"twitter:title\" content=\"こんにちは\">\n<meta property=\"twitter:description\" content=\"こんにちは\"><link rel=\"alternate\" hreflang=\"ja\" href=\"http://ja.page.com/\"><link rel=\"alternate\" hreflang=\"en\" href=\"http://page.com/\"></head>\n<body><h1><!--wovn-src:Mr. Belvedere Fan Club-->ベルベデアさんファンクラブ</h1>\n<div><p><!--wovn-src:Hello-->こんにちは</p></div>\n<!--wovn-src:Hello--><img src=\"http://example.com/photo.png\" alt=\"こんにちは\">\n</body></html>\n"
             when  'meta_img_alt_tags'
               "<html><head><meta name =\"description\" content=\"Hello\">\n<meta name=\"title\" content=\"Hello\">\n<meta property=\"og:title\" content=\"Hello\">\n<meta property=\"og:description\" content=\"Hello\">\n<meta property=\"twitter:title\" content=\"Hello\">\n<meta property=\"twitter:description\" content=\"Hello\"></head>
       <body><h1>Mr. Belvedere Fan Club</h1>
       <div><p>Hello</p></div>
       <img src=\"http://example.com/photo.png\" alt=\"Hello\">
       </body></html>"
             when  'a_href_javascript'
               "<html><body><h1>Mr. Belvedere Fan Club</h1>
                     <div><p><a href=\"javascript:void(0)\">Hello</a></p></div>
                   </body></html>"
             when  'a_href_javascript_translated'
               "<html lang=\"ja\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><script src=\"//j.wovn.io/1\" async=\"true\" data-wovnio=\"key=&amp;backend=true&amp;currentLang=ja&amp;defaultLang=en&amp;urlPattern=path&amp;langCodeAliases={}&amp;version=#{Wovnrb::VERSION}\"> </script><link rel=\"alternate\" hreflang=\"ja\" href=\"http://ja.page.com/\"><link rel=\"alternate\" hreflang=\"en\" href=\"http://page.com/\"></head><body><h1><!--wovn-src:Mr. Belvedere Fan Club-->ベルベデアさんファンクラブ</h1>
                     <div><p><a href=\"javascript:void(0)\"><!--wovn-src:Hello-->こんにちは</a></p></div>
                   </body></html>
       "
             when 'unified_values'
               <<-HTML
        <html><body>
          <div>
            a <span>b</span> c
          </div>
          <div>
            a<span>b</span>
          </div>
          <div>
            <span> b </span>c
          </div>
</body></html>
               HTML

             when 'unified_values_ja'
               <<-HTML
<html lang=\"ja\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><script src=\"//j.wovn.io/1\" async=\"true\" data-wovnio=\"key=&amp;backend=true&amp;currentLang=ja&amp;defaultLang=en&amp;urlPattern=path&amp;langCodeAliases={}&amp;version=#{Wovnrb::VERSION}\"> </script><link rel=\"alternate\" hreflang=\"en\" href=\"http://page.com/\"></head><body>
          <div><!--wovn-src:
            a -->\u3042<span><!--wovn-src:b-->\u3044</span><!--wovn-src: c
          -->\u3046</div>
          <div><!--wovn-src:
            a-->\u200B<span><!--wovn-src:b-->\u3044</span><!--wovn-src:-->\u3046
          </div>
          <div>
            <!--wovn-src:-->\u3042<span><!--wovn-src: b -->\u3044</span><!--wovn-src:c
          -->\u200B</div>

</body></html>
               HTML

             else # "" case
               "<html><body><h1>Mr. Belvedere Fan Club</h1>
                       <div><p>Hello</p></div>
                     </body></html>"
             end

      body
    end

    def generate_dom(param = '')
      Wovnrb.to_dom(generate_body(param))
    end

    def generate_values
      values = {}
      values['text_vals'] = {
        'Hello' => { 'ja' => [{ 'data' => 'こんにちは' }] },
        'Mr. Belvedere Fan Club' => { 'ja' => [{ 'data' => 'ベルベデアさんファンクラブ' }] }
      }
      values
    end

    def generate_unified_values
      {
        'html_text_vals' => {
          'a<span>b</span>c' =>
                { 'ja' =>
                      [{ 'data' => 'あ<span>い</span>う' }] },
          'a<span>b</span>' =>
                { 'ja' =>
                      [{ 'data' => '<span>い</span>う' }] },
          '<span>b</span>c' =>
                { 'ja' =>
                      [{ 'data' => 'あ<span>い</span>' }] }

        }
      }
    end

    def test_get_code_from_custom_lang
      store = Store.instance
      store.settings['custom_lang_aliases'] = { 'ja' => 'staging-ja' }
      assert_equal('ja', Wovnrb::Lang.get_code('staging-ja'))
    end

    def test_add_lang_code_with_custom_lang_aliases
      lang = Lang.new('fr')
      Store.instance.update_settings('custom_lang_aliases' => { 'fr' => 'staging-fr' })
      h = Wovnrb::Headers.new(Wovnrb.get_env('url' => 'http://wovn.io'), Wovnrb.get_settings('url_pattern' => 'subdomain', 'url_pattern_reg' => '^(?<lang>[^.]+).'))
      assert_equal('http://staging-fr.wovn.io/topics/50', lang.add_lang_code('/topics/50', 'subdomain', h))
    end
  end
end
