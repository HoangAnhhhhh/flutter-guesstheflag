import './flag.dart';

class EasyLevel{
  
  static List<Flag> getFlags(){
    List<Flag> _easyFlags = <Flag>[
      Flag('assets/flags/easy/brazil.png'),
      Flag('assets/flags/easy/china.jpg'),
      Flag('assets/flags/easy/japan.jpg'),
      Flag('assets/flags/easy/malaysia.png'),
      Flag('assets/flags/easy/vietnam.jpg'),
    ];
    return _easyFlags;
  }
}