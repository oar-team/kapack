{ cgvg, fetchFromGitHub }:

cgvg.overrideDerivation (attrs: rec {
    name = "cgvg-1.6.3-${version}";
    version = "mpoquet";
    
    src = fetchFromGitHub {
        repo = "cgvg";
        owner = "mpoquet";
        rev = "64bb96bb3d0584b60b49cb22e0681684a3112814";
        sha256= "04h3x0sk79anan3812xgqi44bggmqzvri39gh4k2lk2n7q2xn8c1";
      };
})
