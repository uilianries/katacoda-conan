#include "Poco/MD5Engine.h"
#include "Poco/DigestStream.h"

#include <iostream>


int main(int argc, char** argv)
{
    const std::string word("Katakoda");
    Poco::MD5Engine md5;
    Poco::DigestOutputStream ds(md5);
    ds << word;
    ds.close();
    std::cout << "MD5SUM of " << word << " is " << Poco::DigestEngine::digestToHex(md5.digest()) << std::endl;
    return 0;
}