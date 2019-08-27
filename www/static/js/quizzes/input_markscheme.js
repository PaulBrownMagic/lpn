function markscheme() {
    $(".markscheme").addClass("show")
    for (const ans of $(".answer")) {
        const answer = $(ans)
        if (answer.attr("data-answer") == answer.val()) {
            answer.addClass("is-valid")
            answer.next().find("input").prop("checked", true)
        }
    }
}

function validate(ID, value) {
    const elem = $(ID)
    if (value) {
        elem.removeClass("is-invalid")
        elem.addClass("is-valid")
    }
    else {
        elem.removeClass("is-valid")
        elem.addClass("is-invalid")
    }
}
