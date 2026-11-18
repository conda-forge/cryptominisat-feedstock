#include <cryptominisat5/cryptominisat.h>
#include <cassert>
#include <vector>

using namespace CMSat;

int main() {
    SATSolver solver;
    solver.new_vars(3);

    std::vector<Lit> clause;
    clause.push_back(Lit(0, false));
    solver.add_clause(clause);

    clause.clear();
    clause.push_back(Lit(1, true));
    solver.add_clause(clause);

    clause.clear();
    clause.push_back(Lit(0, true));
    clause.push_back(Lit(1, false));
    clause.push_back(Lit(2, false));
    solver.add_clause(clause);

    lbool ret = solver.solve();
    assert(ret == l_True);
    assert(solver.get_model()[0] == l_True);
    assert(solver.get_model()[1] == l_False);
    assert(solver.get_model()[2] == l_True);

    clause.clear();
    clause.push_back(Lit(2, true));
    solver.add_clause(clause);
    if (solver.solve() != l_False) return 1;
    return 0;
}
