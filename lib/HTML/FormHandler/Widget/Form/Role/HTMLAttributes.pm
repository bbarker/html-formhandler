package HTML::FormHandler::Widget::Form::Role::HTMLAttributes;
# ABSTRACT: set HTML attributes on the form tag

use Moose::Role;

sub html_form_tag {
    my $self = shift;

    my @attr_accessors = (
        [ action  => 'action' ],
        [ id      => 'name' ],
        [ method  => 'http_method' ],
        [ enctype => 'enctype' ],
        [ class   => 'css_class' ],
        [ style   => 'style' ],
    );

    my $element_attr = { %{$self->element_attr} };
    foreach my $attr_pair (@attr_accessors) {
        my $attr = $attr_pair->[0];
        my $accessor = $attr_pair->[1];
        if ( !exists $element_attr->{$attr} && defined( my $value = $self->$accessor ) ) {
            $element_attr->{$attr} = $self->$accessor;
        }
    }

    my $output = '<form';
    foreach my $attr ( sort keys %$element_attr ) {
        $output .= qq{ $attr="} . $element_attr->{$attr} . qq{"};
    }

    $output .= " >\n";
    return $output;
}

no Moose::Role;
1;
