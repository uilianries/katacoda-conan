#include "Poco/MD5Engine.h"
#include "Poco/DigestStream.h"
#include <iostream>

int main()
{
    Poco::MD5Engine md5;
    Poco::DigestOutputStream ds(md5);
    ds << "abcdefghijklmnopqrstuvwxyz";
    ds.close();
    std::cout << "Hello World! Here's the MD5 hash: " << Poco::DigestEngine::digestToHex(md5.digest()) << std::endl;
    return 0;
}
