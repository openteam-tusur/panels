
class PanelsController < ActionController::Base
  protect_from_forgery with: :exception
  def content_base
  @content_base = {
    '1' => {

      '1' => {
        text: 'Задача организации, в особенности же новая модель организационной деятельности требуют определения и уточнения позиций, занимаемых участниками в отношении поставленных задач. Равным образом постоянный количественный рост и сфера нашей активности позволяет выполнять важные задания по разработке форм развития. Разнообразный и богатый опыт начало повседневной работы по формированию позиции требуют определения и уточнения позиций, занимаемых участниками в отношении поставленных задач. Товарищи! консультация с широким активом требуют от нас анализа существенных финансовых и административных условий. Товарищи! сложившаяся структура организации играет важную роль в формировании позиций, занимаемых участниками в отношении поставленных задач. Задача организации, в особенности же консультация с широким активом играет важную роль в формировании позиций, занимаемых участниками в отношении поставленных задач.',
        timeout: 30
      },

      '2' => {
        text: 'Таким образом новая модель организационной деятельности позволяет выполнять важные задания по разработке модели развития. Не следует, однако забывать, что дальнейшее развитие различных форм деятельности требуют от нас анализа форм развития. С другой стороны консультация с широким активом представляет собой интересный эксперимент проверки форм развития.',
        timeout: 30
      },

      '3' => {
        text: 'Равным образом дальнейшее развитие различных форм деятельности требуют определения и уточнения систем массового участия. Таким образом сложившаяся структура организации влечет за собой процесс внедрения и модернизации соответствующий условий активизации. Равным образом сложившаяся структура организации обеспечивает широкому кругу (специалистов) участие в формировании форм развития.',
        timeout: 30
      }},
    '2' => {

      '1' => {
        text: 'Задача организации, в особенности же новая модель организационной деятельности требуют определения и уточнения позиций, занимаемых участниками в отношении поставленных задач. Равным образом постоянный количественный рост и сфера нашей активности позволяет выполнять важные задания по разработке форм развития. Разнообразный и богатый опыт начало повседневной работы по формированию позиции требуют определения и уточнения позиций, занимаемых участниками в отношении поставленных задач. Товарищи! консультация с широким активом требуют от нас анализа существенных финансовых и административных условий. Товарищи! сложившаяся структура организации играет важную роль в формировании позиций, занимаемых участниками в отношении поставленных задач. Задача организации, в особенности же консультация с широким активом играет важную роль в формировании позиций, занимаемых участниками в отношении поставленных задач.',
        timeout: 30
      },

      '2' => {
        text: 'Таким образом новая модель организационной деятельности позволяет выполнять важные задания по разработке модели развития. Не следует, однако забывать, что дальнейшее развитие различных форм деятельности требуют от нас анализа форм развития. С другой стороны консультация с широким активом представляет собой интересный эксперимент проверки форм развития.',
        timeout: 30
      },

      '3' => {
        text: 'Равным образом дальнейшее развитие различных форм деятельности требуют определения и уточнения систем массового участия. Таким образом сложившаяся структура организации влечет за собой процесс внедрения и модернизации соответствующий условий активизации. Равным образом сложившаяся структура организации обеспечивает широкому кругу (специалистов) участие в формировании форм развития.',
        timeout: 30
      }},
    '3' => {

      '1' => {
        text: 'Задача организации, в особенности же новая модель организационной деятельности требуют определения и уточнения позиций, занимаемых участниками в отношении поставленных задач. Равным образом постоянный количественный рост и сфера нашей активности позволяет выполнять важные задания по разработке форм развития. Разнообразный и богатый опыт начало повседневной работы по формированию позиции требуют определения и уточнения позиций, занимаемых участниками в отношении поставленных задач. Товарищи! консультация с широким активом требуют от нас анализа существенных финансовых и административных условий. Товарищи! сложившаяся структура организации играет важную роль в формировании позиций, занимаемых участниками в отношении поставленных задач. Задача организации, в особенности же консультация с широким активом играет важную роль в формировании позиций, занимаемых участниками в отношении поставленных задач.',
        timeout: 30
      },

      '2' => {
        text: 'Таким образом новая модель организационной деятельности позволяет выполнять важные задания по разработке модели развития. Не следует, однако забывать, что дальнейшее развитие различных форм деятельности требуют от нас анализа форм развития. С другой стороны консультация с широким активом представляет собой интересный эксперимент проверки форм развития.',
        timeout: 30
      },

      '3' => {
        text: 'Равным образом дальнейшее развитие различных форм деятельности требуют определения и уточнения систем массового участия. Таким образом сложившаяся структура организации влечет за собой процесс внедрения и модернизации соответствующий условий активизации. Равным образом сложившаяся структура организации обеспечивает широкому кругу (специалистов) участие в формировании форм развития.',
        timeout: 30
      }}
  }
  end
  def show
    @content = content_base[params[:id]][next_slide]
    @content[:data_id] = next_slide
  end

  def next_slide

    if params[:adv_id] && content_base[params[:id]][ (params[:adv_id].to_i+ 1).to_s ]
      (params[:adv_id].to_i + 1).to_s
    else
      '1'
    end
  end
end
