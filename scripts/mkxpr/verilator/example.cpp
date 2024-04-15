#include "paluconsole.h"
#include "paluutil.h"
#include "verilated_vcd_c.h"
#include <Valu.h>
#include <optional>
#include <utility>

using namespace palu;

template <> struct palu::InItem<Valu> {
  Bus<2> op_in;
  Bus<8> a_in;
  Bus<8> b_in;
  Bus<1> in_valid;
};
template <> struct palu::OutItem<Valu> {
  Bus<8> out;
  Bus<1> out_valid;
};

int main() {
  const auto contextp = std::make_unique<VerilatedContext>();
  contextp->debug(0);
  // contextp->randReset(0);
  contextp->traceEverOn(true);
  // contextp->commandArgs(argc, argv);

  const auto alu = std::make_shared<Valu>(contextp.get(), "DUTALU");

  const auto trace = std::make_unique<VerilatedVcdC>();

  alu->trace(trace.get(), 5);
  trace->open("waveform.vcd");

  InItem<Valu> v;
  auto g = [&v](sim_time_t sim_time) {
    if ((sim_time & 1) == 0) {
      v.op_in = rand<3>();
      v.a_in = rand<256>();
      v.b_in = rand<256>();
      v.in_valid = rand<2>();
    }
    return std::optional(v);
  };
  auto d = [&alu](std::optional<InItem<Valu>> i) {
    alu->clk ^= 1;
    alu->eval();
    if (i.has_value()) {
      auto wi = i.value();
      alu->op_in = wi.op_in;
      alu->a_in = wi.a_in;
      alu->b_in = wi.b_in;
      alu->in_valid = wi.in_valid;
    }
  };
  auto i = [&alu](sim_time_t sim_time) {
    return std::optional<InItem<Valu>>(std::in_place, alu->op_in, alu->a_in,
                                       alu->b_in, alu->in_valid);
  };
  auto o = [&alu](sim_time_t sim_time) {
    return std::optional<OutItem<Valu>>(std::in_place, alu->out,
                                        alu->out_valid);
  };
  auto s = [&trace](ScbID<Valu> &, ScbOD<Valu> &, sim_time_t sim_time) {
    trace->dump(sim_time);
  };

  CatchPalu(palu, Valu, g, d, i, o, s, 100);

  palu.palu_GO();

  return 0;
}
