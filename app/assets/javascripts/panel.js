$(document).ready(function() {
  $(".masq").keydown(function (e) {
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
      (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
      (e.keyCode == 67 && (e.ctrlKey === true || e.metaKey === true)) ||
      (e.keyCode == 88 && (e.ctrlKey === true || e.metaKey === true)) ||
      (e.keyCode >= 35 && e.keyCode <= 39)) {
        return;
    }
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
      e.preventDefault();
    }
  });
  $(document).on("change", ".campos", function() {
    var sum_tvv = 0;
    var sum_tvt = 0;
    $(".cvv").each(function(){
      sum_tvv += +$(this).val();
    });
    $(".tvv").val(sum_tvv);
    $(".campos").each(function(){
      sum_tvt += +$(this).val();
    });
    $(".tvt").val(sum_tvt);
  });
  $(document).on("change", ".campos", function() {

  });
  $( "#b_env" ).click(function() {
    if ($(".tvm").val() != $(".tvt").val()) {
      alert( "Alerta:\n\nEl total de votos de la mesa no concuerda con el total de votos sumados. Por favor verifique nuevamente los datos introducidos." );
    }
  });
});
