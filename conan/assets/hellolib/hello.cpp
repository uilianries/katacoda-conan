#include <Poco/MD5Engine.h>
#include <Poco/DigestStream.h>

#include "hello.h"

std::string HelloGenerator::getHello()
{
    Poco::MD5Engine md5;
    Poco::DigestOutputStream ds(md5);
    ds << "abcdefghijklmnopqrstuvwxyz";
    ds.close();
    return "Hello World! Here's the MD5 hash: " + Poco::DigestEngine::digestToHex(md5.digest());
}
