#ifndef PALUUTIL_H_
#define PALUUTIL_H_

#include <ctime>
#include <random>

namespace palu {

template <size_t width = 64>
class Bus {
private:
  static constexpr uint64_t mask = ~((~0) << width);

  uint64_t data;

public:
  constexpr Bus(uint64_t v = 0) : data(v & mask) {}
  constexpr Bus(const Bus &) = default;
  constexpr Bus(Bus &&)      = default;
  ~Bus()                     = default;

  constexpr uint64_t get() const { return data; }
  constexpr void     set(uint64_t v) { data = v & mask; }
  constexpr          operator uint64_t() const { return get(); }
  constexpr Bus      operator=(uint64_t v) { return (set(v), *this); }
  template <size_t RHS_width>
  constexpr Bus operator=(const Bus<RHS_width> &v) {
    return (set(v.get()), *this);
  }
  template <size_t RHS_width>
  constexpr bool operator==(const Bus<RHS_width> &v) {
    return get() == v.get();
  }
};

template <size_t upperbound, bool timeseeded = true, size_t lowerbound = 0>
auto rand() {
  static std::mt19937_64                       e(timeseeded ? time(0) : 0);
  static std::uniform_int_distribution<size_t> d(lowerbound, upperbound - 1);
  return d(e);
}

}  // namespace palu

#endif  // !PALUUTIL_H_
