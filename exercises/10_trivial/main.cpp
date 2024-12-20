#include "../exercise.h"

// READ: Trivial type <https://learn.microso当 C++ 中的类或结构具有编译器提供的或显式默认设置的特殊成员函数时，该类或结构为普通类型。ft.com/zh-cn/cpp/cpp/trivial-standard-layout-and-pod-types?view=msvc-170>
// NOTE：这里提到的标准类型 应该相当于
struct FibonacciCache {
    unsigned long long cache[16];
    int cached;
public: 
    FibonacciCache() : cache{0, 1}, cached(2) {  };
};

// TODO: 实现正确的缓存优化斐波那契计算
static unsigned long long fibonacci(FibonacciCache &cache, int i) {
  if (i < cache.cached) {
    return cache.cache[i];
  }
  for (; cache.cached <= i; ++cache.cached) {
      cache.cache[cache.cached] = cache.cache[cache.cached - 1] + cache.cache[cache.cached - 2];
  }
  return cache.cache[i];
}

int main(int argc, char **argv) {
    // TODO: 初始化缓存结构体，使计算正确
    // NOTICE: C/C++ 中，读取未初始化的变量（包括结构体变量）是未定义行为
    // READ: 初始化的各种写法 <https://zh.cppreference.com/w/cpp/language/initialization>
    FibonacciCache fib;
    ASSERT(fibonacci(fib, 10) == 55, "fibonacci(10) should be 55");
    std::cout << "fibonacci(10) = " << fibonacci(fib, 10) << std::endl;
    return 0;
}
