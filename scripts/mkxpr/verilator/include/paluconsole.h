#ifndef PALUCONSOLE_H_
#define PALUCONSOLE_H_

#include <optional>
#include <vector>

namespace palu {

using sim_time_t = size_t;

template <typename DUT> struct InItem;
template <typename DUT> struct OutItem;

template <typename G, typename DUT>
concept InGnr = requires(G g, sim_time_t sim_time) {
  { g(sim_time) } -> std::same_as<std::optional<InItem<DUT>>>;
};

template <typename D, typename DUT>
concept InDrv = requires(D d, std::optional<InItem<DUT>> i) {
  { d(i) } -> std::same_as<void>;
};

template <typename M, typename DUT>
concept InMnt = requires(M m, DUT dut, sim_time_t sim_time) {
  { m(sim_time) } -> std::same_as<std::optional<InItem<DUT>>>;
};

template <typename M, typename DUT>
concept OutMnt = requires(M m, DUT dut, sim_time_t sim_time) {
  { m(sim_time) } -> std::same_as<std::optional<OutItem<DUT>>>;
};

template <typename DUT> using ScbID = std::vector<InItem<DUT>>;
template <typename DUT> using ScbOD = std::vector<OutItem<DUT>>;

template <typename B, typename DUT>
concept ScrBrd =
    requires(B b, ScbID<DUT> id, ScbOD<DUT> od, sim_time_t sim_time) {
      { b(id, od, sim_time) } -> std::same_as<void>;
    };

template <typename DUT, InGnr<DUT> G, InDrv<DUT> D, InMnt<DUT> I, OutMnt<DUT> O,
          ScrBrd<DUT> S>
struct PaluConsole {
private:
  G rig;
  D drv;
  I im;
  O om;
  S scb;

  sim_time_t cur_time;
  sim_time_t max_time;

  std::vector<InItem<DUT>> in_data;
  std::vector<OutItem<DUT>> out_data;

public:
  PaluConsole(G rig, D drv, I im, O om, S scb, sim_time_t max_time = 50)
      : rig(rig), drv(drv), im(im), om(om), scb(scb), cur_time(0),
        max_time(max_time) {}
  void set_sim_time(sim_time_t max_time) { this->max_time = max_time; }

  void palu_GO() {
    cur_time = 0;
    while (cur_time < max_time) {
      auto i = rig(cur_time);
      drv(i);
      auto oi = im(cur_time);
      if (oi.has_value()) {
        in_data.push_back(oi.value());
      }
      auto oo = om(cur_time);
      if (oo.has_value()) {
        out_data.push_back(oo.value());
      }
      scb(in_data, out_data, cur_time);
      ++cur_time;
    }
  }
};

#define CatchPalu(paluname, dutname, g, d, i, o, s, t)                         \
  PaluConsole<dutname, decltype(g), decltype(d), decltype(i), decltype(o),     \
              decltype(s)>                                                     \
      paluname {                                                               \
    g, d, i, o, s, t                                                           \
  }

} // namespace palu

#endif // !PALUCONSOLE_H_
