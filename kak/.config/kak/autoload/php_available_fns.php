<?php

global $std_classes;
$std_classes = get_declared_classes();

function classes_in_file($file){
    global $std_classes;
    include_once($file);
    $all_classes = get_declared_classes();
    return array_diff($all_classes, $std_classes);
}

function show_fn_completion(ReflectionMethod $meth) {

    $doc_lines = preg_split('/$\R?^/m', $meth->getDocComment());
	$text_line = current(preg_grep('/\w/', $doc_lines));
	$text_line = preg_replace('/^\W+/', "", $text_line);
    # Kak uses candidate|desc|menutext
    return sprintf("%s|%s|%s->%s",
        $meth->getName(),
        $text_line,
        $meth->getDeclaringClass()->getName(),
        $meth->getName()
    );
}

$clses = array_map(function ($n) {
    return new ReflectionClass($n);
}, classes_in_file($argv[1]));

$completions = [];
foreach ($clses as $c) {
    foreach ($c->getMethods() as $m) {
        $completions[] = show_fn_completion($m);
    }
}
echo implode(":", $completions);
