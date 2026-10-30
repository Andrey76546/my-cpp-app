#include <gtest/gtest.h>

#include <string>

#include "greeting.hpp"

TEST(GreetingTest, ReturnsCorrectString) {
  EXPECT_EQ(getGreeting(), "Hello from C++ in Docker! 🐳");
}

TEST(GreetingTest, ContainsKeywords) {
  const std::string greeting = getGreeting();
  EXPECT_NE(greeting.find("C++"), std::string::npos);
  EXPECT_NE(greeting.find("Docker"), std::string::npos);
}

TEST(GreetingTest, IsNotEmpty) { EXPECT_FALSE(getGreeting().empty()); }
