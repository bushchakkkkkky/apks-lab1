#include <gtest/gtest.h>
#include "hello_lib.h"

TEST(MathTest, BasicAddition) {
    EXPECT_EQ(5, add(2, 3));
}

TEST(GreetingTest, ReturnsHelloWorld) {
    EXPECT_EQ("Hello, World!", greeting());
}
