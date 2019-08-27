document.addEventListener("DOMContentLoaded", start_quiz("/static/pl/auto-compare.pl"), false);

$("#quiz").find("input").blur(check_answer);

function check_answer(e) {
    const answer = e.target.value
    const question = $(e.target).prev().text()
    const query = `check_answer(\'${question}\', \'${answer}\').`
    session.query(query)
    session.answer((a) => {})
}


